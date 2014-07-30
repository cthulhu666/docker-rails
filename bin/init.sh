#!/bin/bash

set -eu

# setup passwordless sudo
echo "rails         ALL = (ALL) NOPASSWD: ALL" > /etc/sudoers.d/rails
chmod 0440 /etc/sudoers.d/rails