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
