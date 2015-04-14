Git
===

Add tracking in existing source
-------------------------------

```
git init
git remote add origin https://github.com/a/b.git
git fetch
git branch master origin/master
git reset --hard origin/master
```

[link](http://stackoverflow.com/questions/11266478/git-add-remote-branch)

Add tag
-------

```git
git tag -a v1.0 -m "Version 1.0 Stable"
git push --tags
```
