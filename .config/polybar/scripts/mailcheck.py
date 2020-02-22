#!/bin/python3
import imaplib
import json
import os

file = os.path.expanduser('~/.config/account.json')
with open(file, 'r') as f:
    account = json.load(f)

obj = imaplib.IMAP4_SSL('partner.outlook.cn',993)
obj.login(account['user'], account['pass'])
obj.select()
print(len(obj.search(None, 'UnSeen')[1][0].split()))
