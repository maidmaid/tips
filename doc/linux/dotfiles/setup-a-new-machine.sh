#!/usr/bin/env bash
echo "link dot files in home dir. hit ctrl-c NOW"
read -n 1

ln -fsv "$(pwd)/.bash_aliases" ~/.bash_aliases
ln -fsv "$(pwd)/.gitattributes" ~/.gitattributes
ln -fsv "$(pwd)/.gitconfig" ~/.gitconfig
ln -fsv "$(pwd)/.gitconfig.local" ~/.gitconfig.local
ln -fsv "$(pwd)/.gitignore" ~/.gitignore
. ~/.bashrc
