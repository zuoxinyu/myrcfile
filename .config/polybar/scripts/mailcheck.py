#!/bin/python3
import imaplib
import json
import os
import subprocess

try:
    file = os.path.expanduser('~/.config/account.json')
    with open(file, 'r') as f:
        account = json.load(f)

    password = subprocess.run(['pass', 'show', 'megvii/login'], capture_output=True).stdout.strip().decode('utf-8')
    session = imaplib.IMAP4_SSL('partner.outlook.cn',993)
    session.login(account['user'], password)
    session.select()
    print(len(session.search(None, 'UnSeen')[1][0].split()))
except:
    print('x')
