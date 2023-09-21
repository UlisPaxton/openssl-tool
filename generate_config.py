""" Скрипт генерации конфигурационного файла OpenSSL"""

import argparse
from jinja2 import Environment, FileSystemLoader


parser = argparse.ArgumentParser()
parser.add_argument('fqdn', type=str, help="FQDN")
args = parser.parse_args()
env = Environment(loader=FileSystemLoader('templates'))
template = env.get_template('openssl.conf.j2')
context = {'fqdn': args.fqdn}
configured_template = template.render(context=context)

with open(f"{args.fqdn}.ssl.conf", 'w', encoding="UTF-8") as config:
    config.write(configured_template)
