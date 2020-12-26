#!/bin/bash
echo "deploy app"
cd ~
apt-get install -y git
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
echo "deploy finished"
