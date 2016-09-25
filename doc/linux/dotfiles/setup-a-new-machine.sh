echo "do not run this script in one go. hit ctrl-c NOW"
read -n 1

ln -fs "$(pwd)/.bash_aliases" ~/.bash_aliases
ln -fs "$(pwd)/.gitattributes" ~/.gitattributes
ln -fs "$(pwd)/.gitconfig" ~/.gitconfig
ln -fs "$(pwd)/.gitconfig.local" ~/.gitconfig.local
ln -fs "$(pwd)/.gitignore" ~/.gitignore
