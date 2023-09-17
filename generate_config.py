""" Скрипт генерации конфигурационного файла OpenSSL"""

import argparse
import socket
from jinja2 import Environment, FileSystemLoader


parser = argparse.ArgumentParser()
parser.add_argument('fqdn', type=str, help="FQDN")
args = parser.parse_args()
try:
    ip = socket.gethostbyname(args.fqdn)
except socket.gaierror:
    print(f"[ - ] Can`t resolve domain name {args.fqdn} , enter IP manually.")
    ip = input("IP: ")

hostname = args.fqdn.split(".")[0]
env = Environment(loader=FileSystemLoader('templates'))
template = env.get_template('openssl.conf.j2')
context = {'fqdn': args.fqdn, "ip": ip, 'hostname': hostname}
configured_template = template.render(context=context)

with open(f"{args.fqdn}.ssl.conf", 'w', encoding="UTF-8") as config:
    config.write(configured_template)
