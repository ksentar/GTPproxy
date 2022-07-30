#!/usr/bin/env python3
import yaml
import re
from yaml.loader import BaseLoader

with open('.services.yaml') as f:
    services = yaml.load(f, Loader=BaseLoader)
    services = ['compose/compose.' + service + '.yaml' for service in services]
    compose_file = ':'.join(services)

with open('.env') as f:
    text = f.read()
    new_env = re.sub(r'^COMPOSE_FILE=.*', 'COMPOSE_FILE=' +
                     compose_file, text, flags=re.MULTILINE)

with open('.env', 'w') as f:
    f.write(new_env)
