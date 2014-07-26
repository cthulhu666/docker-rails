#!/bin/bash

set -eu

# generate a password for rails.
RAILS_PASSWORD=$(pwgen -c -n -1 12)
echo "rails:$RAILS_PASSWORD" | chpasswd
echo User: rails Password: $RAILS_PASSWORD

/etc/init.d/ssh start

exec $@