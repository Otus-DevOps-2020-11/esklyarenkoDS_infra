#!/bin/bash
echo "install ruby"
sudo apt update
sleep 25
sudo apt install -y ruby-full ruby-bundler build-essential
echo "ruby installed"
