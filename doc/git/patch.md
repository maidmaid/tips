Patch
-----

- First step : fork, clone, create ``feature666`` branch, commit, push. 

- Add upstream remote :

```
$ git remote add upstream https://github.com/symfony/symfony.git
```

- *Show remote :*

```
$ git remote -v
origin      https://github.com/maidmaid/symfony.git (fetch)
origin      https://github.com/maidmaid/symfony.git (push)
upstream    https://github.com/symfony/symfony.git (fetch)
upstream    https://github.com/symfony/symfony.git (push)
```

- Update master from upstream :

```
$ git checkout master
$ git fetch upstream
$ git merge upstream/master
$ git checkout feature666
```

- Rebase master :

```
$ git rebase master
$ git rebase --continue
```

- Force push ``feature666`` :

```
$ git push --force origin feature666
```

[link](http://symfony.com/doc/current/contributing/code/patches.html#rebase-your-patch)
