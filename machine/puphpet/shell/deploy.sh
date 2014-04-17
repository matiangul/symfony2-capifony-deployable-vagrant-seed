#!/bin/bash
echo 'Setting up deployment'
sudo apt-get install ant -y
sudo apt-get remove nodejs nodejs-dev npm -y
sudo add-apt-repository ppa:chris-lea/node.js -y #or add-apt-repository ppa:richarvey/nodejs
sudo apt-get update
sudo apt-get install nodejs -y
sudo apt-get install rubygems -y
sudo gem install capifony -y
sudo gem uninstall net-ssh -v 2.8.0
sudo gem install net-ssh -v 2.7
