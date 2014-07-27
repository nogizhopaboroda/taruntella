#!/bin/bash

cd ~/
mkdir .taruntella
cd .taruntella
curl -L https://raw.githubusercontent.com/nogizhopaboroda/taruntella/master/runner.sh > runner.sh
chmod 777 runner.sh
shopt -s expand_aliases
alias taruntella=~/.taruntella/runner.sh
alias
echo 'alias taruntella=~/.taruntella/runner.sh' >> ~/.zshrc
echo 'Taruntella runner successfuly installed'
echo 'Reopen your terminal and type "taruntella"'