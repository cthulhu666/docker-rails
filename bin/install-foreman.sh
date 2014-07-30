#!/bin/bash

set -eu

su - rails <<'EOF'
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
gem install foreman
rbenv rehash
EOF