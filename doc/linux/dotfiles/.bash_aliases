#!/usr/bin/env bash

# Create tmp dir and cd
alias tmp='dir=$(mktemp -d) && cd $dir'

# Refresh wifi list
alias wifi='sudo iwlist wlan0 scan'

# Test quickly PHP package
function tst () {
  dir=$(mktemp -d)
  cd $dir
  composer require symfony/var-dumper $P -n
  printf "<?php\n\nrequire 'vendor/autoload.php';\n\ndump('ok');\n" > index.php
  php index.php
  git init
  echo /vendor/ > .gitignore
  echo /.idea/ >> .gitignore
  git add .
  git commit -m "Add index.php"
  phpstorm . ./index.php:5
}

# Test quickly Symfony
function tstsf () {
  dir=$(mktemp -d)
  cd $dir
  composer create-project symfony/skeleton . $V
  composer require log server var-dumper annotations maker:dev-master $P -n
  php bin/console make:command app
  php bin/console make:controller AppController
  php bin/console server:start
  # php bin/console server:log
  git init --quiet
  echo /.idea/ >> .gitignore
  git add .
  git commit -m "Import Symfony project" --quiet
  pstorm . \
    ./src/Controller/AppController.php:16 \
    ./src/Command/AppCommand.php:28
}

# Add global composer packages
export PATH=$PATH:~/.composer/vendor/bin

# Add PHPBrew
source ~/.phpbrew/bashrc

# Add CFFie alias
alias cff='cffie query --notify'
alias cffw='watch -ctn 30 cffie query --ansi'

# Add z command
source ~/Dev/z/z.sh

# Add cd nav
alias ..='cd ..'
alias cd..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Add Git alias
alias g="git"

# Add Vim alias
alias v="vim"

# Add PHPBrew bash
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# Psysh-sf
alias psysh-sf='php ~/Dev/tips/doc/php/psysh-sf.php'
