Run scenarios in Gitlab CI
==========================

In ``.gitlab-ci.yml`` :

```yml
before_script:
  - uname -a
  - php -v
  - blackfire-player --version
  - composer install --no-progress -n
  - php app/console doctrine:database:create --if-not-exists -n
  - php app/console doctrine:schema:update --complete --force -n
  - php app/console doctrine:fixtures:load -n

test:
  script:
    - php app/console server:start --force -n
    - blackfire-player run scenarios.yml -vv
    - php app/console server:stop -n
```