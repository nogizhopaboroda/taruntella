#!/bin/bash

cd ~/
mkdir .bash_task_runner
cd .bash_task_runner
curl -L https://raw.githubusercontent.com/nogizhopaboroda/bash_task_runner/master/runner.sh > runner.sh
chmod 777 runner.sh
shopt -s expand_aliases
alias barun=~/.bash_task_runner/runner.sh
alias
echo 'alias barun=~/.bash_task_runner/runner.sh' >> ~/.zshrc
echo 'Bash task runner successfuly installed'
echo 'Reopen your terminal and type "barun"'