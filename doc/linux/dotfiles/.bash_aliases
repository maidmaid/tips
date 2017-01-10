# Create tmp dir and cd
alias tmp='dir=$(mktemp -d) && cd $dir'

# Refresh wifi list
alias wifi='sudo iwlist wlan0 scan'

# Test quickly PHP package
function tst () {
  dir=$(mktemp -d)
  cd $dir
  composer require symfony/var-dumper $CR -n
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
  symfony new . $V
  php bin/console generate:command AppBundle app --no-interaction --quiet
  php bin/console server:start --force --quiet
  git init --quiet
  echo /.idea/ >> .gitignore
  git add .
  git commit -m "Import Symfony project" --quiet
  google-chrome 127.0.0.1:8000 > /dev/null 2>&1
  phpstorm . \
    ./app/config/parameters.yml \
    ./app/config/config.yml \
    ./app/Resources/views/default/index.html.twig \
    ./src/AppBundle/Controller/DefaultController.php:16 \
    ./src/AppBundle/Command/AppCommand.php:28
}

# Add global composer packages
export PATH=$PATH:~/.composer/vendor/bin

# Add PHPBrew
source ~/.phpbrew/bashrc

# Add CFFie alias
alias cff='cffie query --notify'

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

# Add liquidprompt bash
[[ $- = *i* ]] && source ~/Dev/liquidprompt/liquidprompt

# Add PHPBrew bash
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# PhpStorm
alias pstorm="phpstorm"

# Psysh-sf
alias psysh-sf='php ~/Dev/tips/doc/php/psysh-sf.php'