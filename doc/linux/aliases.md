Useful aliases
==============

### Create tmp dir and cd

```bash
alias tmp='dir=$(mktemp -d) && cd $dir'
```


### Test quickly PHP package

```bash
function tst () {
  dir=$(mktemp -d)
  cd $dir
  composer require $CR -n
  printf "<?php\n\nrequire 'vendor/autoload.php';\n\n" > index.php
  pstorm . ./index.php:5
}
```

Usage :

```bash
$ CR=guzzlehttp/guzzle tst
```

- _CR_ : **C**omposer **R**equire

### Test quickly Symfony

```bash
function tstsf () {
  dir=$(mktemp -d)
  cd $dir
  symfony new .
  php bin/symfony_requirements
  pstorm . \
    ./app/config/parameters.yml \
    ./app/config/config.yml \
    ./app/Resources/views/default/index.html.twig \
    ./src/AppBundle/Controller/DefaultController.php:16
}
```
