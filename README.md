TaRunTella
================

Bash script task runner that can run task from remote source

## Features

### Run tiny tasks

```shell
taruntella hello
```
	
### Run tasks from gist/github/anywhere

```shell
taruntella https://gist.githubusercontent.com/nogizhopaboroda/6a9e6b58737c157b0ae4/raw/6ceddcc3aecd77af0b346e3e22f65df6c9997ccc/taruntella_example.sh test
```

## Writing a tasks
All tasks are located in Ttasks file. Just put it in any directory and type

```shell
taruntella tasks
```

and you'll see a list if tasks for this directory

### Ttasks file example
Ttasks file is a list of bashscript functions. For example:

```bash
function hello() {
	echo 'hello'
}

function foo() {
	#do something
}
```


You can pass agruments to task. Agruments in tasks is available as $1, $2, ...
```bash
function pass() {
	echo "argument: ${1}"
}	
```

## Installation

### Bootstrap

```shell
curl -L https://raw.githubusercontent.com/nogizhopaboroda/taruntella/master/install.sh | bash
```

### From git repository

```shell
git clone git@github.com:nogizhopaboroda/taruntella.git
```

Then type 
```shell
./runner.sh
```
in cloned directory

## Uninstallation
```shell
taruntella uninstall
```

