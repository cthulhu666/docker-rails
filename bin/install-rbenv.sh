#!/bin/bash

set -eu

su - rails <<'EOF'
git clone https://github.com/sstephenson/rbenv.git /home/rails/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/rails/.bashrc
echo 'eval "$(rbenv init -)"' >> /home/rails/.bashrc
git clone https://github.com/sstephenson/ruby-build.git /home/rails/.rbenv/plugins/ruby-build
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
rbenv install 2.1.2
rbenv global 2.1.2
gem install bundler --no-ri --no-rdoc
rbenv rehash
EOF