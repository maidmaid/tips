Project analysis
================

- Define front-office routes
- Define back-office routes
- Define entities, fields and extensions doctrines
- Define security

Developpement
=============

Import project
--------------

- Create new project with symfony.phar
- Delete ACME bundle
- Restructure namespaces in ``/src``
- Update dependencies and create ``composer.lock`` by running ``composer update``
- Commit "import symfony project"

Import assets
-------------

- Add assets files in ``/web``
- Edit base template
- Commit "import assets"

Create entities
---------------

- Generate basics entities by running ``php app/console doctrine:generate:entity``
- Delete useless comments in created repositories
- Add joins, generate setter/getter by running ``php app/console doctrine:generate:entities`` and add ``cascade`` option
- Add ``nullable`` annotation option and/or ``default`` annotation option. Add default value in constructor.
- Add [validation constraints](http://symfony.com/doc/current/reference/constraints.html)
- Commit "add entities"

Configure project
-----------------

- Edit template params in ``parameters.yml.dist``
- Configure doctrine with [naming strategie](http://doctrine-orm.readthedocs.org/en/latest/reference/namingstrategy.html) to ``underscore``
