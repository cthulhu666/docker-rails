#!/bin/bash

set -eu

# keep nginx in foreground so supervisor can manage it
#conf_file='/etc/nginx/nginx.conf'
#echo "daemon off;" >> "${conf_file}"

# setup passwordless sudo
echo "rails         ALL = (ALL) NOPASSWD: ALL" > /etc/sudoers.d/rails
chmod 0440 /etc/sudoers.d/rails