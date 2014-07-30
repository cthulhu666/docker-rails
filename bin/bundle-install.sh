#!/bin/bash

set -eu

su - rails <<'EOF'
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
cd /home/rails/rails-app
bundle install --without development test --deployment
EOF