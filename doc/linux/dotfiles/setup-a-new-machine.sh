#!/usr/bin/env bash
echo "link dot files in home dir. hit ctrl-c NOW"
read -n 1

ln -fsv "$(pwd)/.bash_aliases" ~/.bash_aliases
ln -fsv "$(pwd)/.gitattributes" ~/.gitattributes
ln -fsv "$(pwd)/.gitconfig" ~/.gitconfig
ln -fsv "$(pwd)/.gitconfig.local" ~/.gitconfig.local
ln -fsv "$(pwd)/.gitignore" ~/.gitignore
. ~/.bashrc

echo "install deps. hit ctrl-c NOW"
read -n 1

# dir
mkdir ~/Dev
cd ~/Dev

# liquid prompt
git clone https://github.com/nojhan/liquidprompt.git

# z
git clone https://github.com/rupa/z.git

# HTTPie
sudo apt-get install httpie

# htop
sudo apt-get install htop

# vim
sudo apt-get install vim

# PHP
sudo apt-get build-dep php
sudo apt-get install -y php php-dev php-pear autoconf automake curl libcurl3-openssl-dev build-essential libxslt1-dev re2c libxml2 libxml2-dev php-cli bison libbz2-dev libreadline-dev
sudo apt-get install -y libfreetype6 libfreetype6-dev libpng12-0 libpng12-dev libjpeg-dev libjpeg8-dev libjpeg8  libgd-dev libgd3 libxpm4 libltdl7 libltdl-dev
sudo apt-get install -y libssl-dev openssl
sudo apt-get install -y gettext libgettextpo-dev libgettextpo0
sudo apt-get install -y libicu-dev
sudo apt-get install -y libmhash-dev libmhash2
sudo apt-get install -y libmcrypt-dev libmcrypt4
sudo apt-get install -y mysql-server mysql-client libmysqlclient-dev libmysqld-dev

# PHPBrew
curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
chmod +x phpbrew
sudo mv phpbrew /usr/local/bin/phpbrew
phpbrew init
phpbrew update
phpbrew known
phpbrew install 5.6 +default+mb+mysql+pdo+debug+intl+iconv
phpbrew install 7.0 +default+mb+mysql+pdo+debug+intl+iconv
phpbrew install 7.1 +default+mb+mysql+pdo+debug+intl+iconv

# Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === 'aa96f26c2b67226a324c27919f1eb05f21c248b987e6195cad9690d5c1ff713d53020a02ac8c217dbf90a7eacc9d141d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
chmod +x composer.phar
sudo mv composer.phar /usr/local/bin/composer

# Symfony Installer
sudo curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
sudo chmod a+x /usr/local/bin/symfony

# PsySH
wget https://git.io/psysh
chmod +x psysh
sudo mv psysh /usr/local/bin/psysh

# CFFie
sudo curl -LsS https://github.com/maidmaid/cffie/releases/download/v0.3.0/cffie.phar -o /usr/local/bin/cffie
sudo chmod a+x /usr/local/bin/cffie

# nodejs
sudo apt-get install -y nodejs npm

# diff-so-fancy
sudo npm install -g diff-so-fancy
