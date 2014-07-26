#!/bin/bash

set -eu

curl -sSL https://get.rvm.io | sudo bash -s stable
/usr/local/rvm/bin/rvm install 2.1
/usr/local/rvm/bin/rvm alias create default 2.1

conf_file='/etc/nginx/nginx.conf'

# Stay alive to allow Docker to manage it
echo "daemon off;" >> "${conf_file}"