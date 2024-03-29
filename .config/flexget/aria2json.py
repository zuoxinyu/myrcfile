import os
import xmlrpc.client
import jsonrpclib as rpc
import base64
from socket import error as socket_error

from loguru import logger

from flexget import plugin
from flexget.event import event
from flexget.utils.template import RenderError

logger = logger.bind(name='aria2')


class OutputAria2JSON:
    """
    Simple Aria2 output

    Example::

        aria2:
          path: ~/downloads/

    """

    schema = {
        'type': 'object',
        'properties': {
            'server': {'type': 'string', 'default': 'localhost'},
            'port': {'type': 'integer', 'default': 6800},
            'urlpath': {'type': 'string', 'default': '/rpc'},
            'rpc': {'enum': ['xmlrpc', 'jsonrpc'], 'default': 'xmlrpc'},
            'secret': {'type': 'string', 'default': ''},
            'username': {'type': 'string', 'default': ''},  # NOTE: To be deprecated by aria2
            'password': {'type': 'string', 'default': ''},
            'path': {'type': 'string'},
            'filename': {'type': 'string'},
            'options': {
                'type': 'object',
                'additionalProperties': {'oneOf': [{'type': 'string'}, {'type': 'integer'}]},
            },
        },
        'required': ['path'],
        'additionalProperties': False,
    }

    aria2 = None

    def aria2_connection(self, config):
        username, password = config['username'], config['password']
        server, port, path = config

        if username and password:
            userpass = '%s:%s@' % (username, password)
        else:
            userpass = ''
        url = 'http://%s%s:%s%s' % (userpass, server, port, path)
        logger.debug('aria2 url: {}', url)
        logger.info('Connecting to daemon at {}', url)
        try:
            self.aria2 = rpc.Server(url).aria2
        except xmlrpc.client.ProtocolError as err:
            raise plugin.PluginError(
                'Could not connect to aria2 at %s. Protocol error %s: %s'
                % (url, err.errcode, err.errmsg),
                logger,
            )
        except xmlrpc.client.Fault as err:
            raise plugin.PluginError(
                'XML-RPC fault: Unable to connect to aria2 daemon at %s: %s'
                % (url, err.faultString),
                logger,
            )
        except socket_error as e:
            raise plugin.PluginError(
                'Socket connection issue with aria2 daemon at %s: %s' % (url, e), logger
            )
        except:
            logger.opt(exception=True).debug('Unexpected error during aria2 connection')
            raise plugin.PluginError(
                'Unidentified error during connection to aria2 daemon', logger
            )

    def prepare_config(self, config):
        config.setdefault('server', 'localhost')
        config.setdefault('port', 6800)
        config.setdefault('urlpath', '/rpc')
        config.setdefault('rpc', 'xmlrpc')
        config.setdefault('username', '')
        config.setdefault('password', '')
        config.setdefault('secret', '')
        config.setdefault('options', {})
        return config

    def on_task_output(self, task, config):
        # don't add when learning
        if task.options.learn:
            return
        config = self.prepare_config(config)
        aria2 = self.aria2_connection(config)
        for entry in task.accepted:
            if task.options.test:
                logger.debug('Would add `{}` to aria2.', entry['title'])
                continue
            try:
                self.add_entry(aria2, entry, config)
            except socket_error as se:
                entry.fail('Unable to reach Aria2: %s' % se)
            except xmlrpc.client.Fault as err:
                logger.critical('Fault code {} message {}', err.faultCode, err.faultString)
                entry.fail('Aria2 communication Fault')
            except Exception as e:
                logger.opt(exception=True).debug('Exception type {}', type(e))
                raise

    def add_entry(self, aria2, entry, config):
        """
        Add entry to Aria2
        """
        options = config['options']
        try:
            options['dir'] = os.path.expanduser(entry.render(config['path']).rstrip('/'))
        except RenderError as e:
            entry.fail('failed to render \'path\': %s' % e)
            return
        if 'filename' in config:
            try:
                options['out'] = os.path.expanduser(entry.render(config['filename']))
            except RenderError as e:
                entry.fail('failed to render \'filename\': %s' % e)
                return
        secret = None
        if config['secret']:
            secret = 'token:%s' % config['secret']
        # handle torrent files
        if 'torrent' in entry:
            if 'file' in entry:
                torrent_file = entry['file']
            elif 'location' in entry:
                # in case download plugin moved the file elsewhere
                torrent_file = entry['location']
            else:
                entry.fail('Cannot find torrent file')
                return
            bytes = base64.encodebytes(open(torrent_file, mode='rb').read())
            if secret:
                return aria2.addTorrent(secret, bytes, [], options)
            return aria2.addTorrent(bytes, [], options)
        # handle everything else (except metalink -- which is unsupported)
        # so magnets, https, http, ftp .. etc
        if secret:
            return aria2.addUri(secret, [entry['url']], options)
        return aria2.addUri([entry['url']], options)

    def add_torrent(self, file, options):
        if self.rpc == 'xmlrpc':
            return self.aria2.addTorrent(xmlrpc.client.Binary(file), [], options)
        elif self.rpc == 'jsonrpc':
            return self.aria2.addTorrent(base64.encodebytes(file), [], options)

@event('plugin.register')
def register_plugin():
    plugin.register(OutputAria2JSON, 'aria2json', api_ver=2)
