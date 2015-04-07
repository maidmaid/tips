Project analysis
================

- Define front-office routes.
- Define back-office routes.
- Define entities, fields and extensions doctrines.
- Define security.

Developpement
=============

Import project
--------------

- Create new project with symfony.phar.
- Delete ACME bundle.
- Restructure namespaces in ``/src``.
- Update dependencies and create ``composer.lock`` by running ``composer update``.

> ``git commit -m "import symfony project"``

Configure project
-----------------

- Edit template params in ``parameters.yml.dist``.
- Configure doctrine with [naming strategy](http://doctrine-orm.readthedocs.org/en/latest/reference/namingstrategy.html) to ``underscore``.

> ``git commit -m "update configuration"``

Import assets
-------------

- Add assets files in ``/web``.
- Edit base template.

> ``git commit -m "import assets"``

Create entities
---------------

- Generate basics entities by running ``php app/console doctrine:generate:entity``.
- Delete useless comments in created repositories.
- Add joins, generate setter/getter by running ``php app/console doctrine:generate:entities`` and add ``cascade`` option.
- Add ``nullable`` annotation option and/or ``default`` annotation option. Add default value in constructor.
- Add [validation constraints](http://symfony.com/doc/current/reference/constraints.html).

> ``git commit -m "add entities"``

- Add [extensions doctrine](https://github.com/stof/StofDoctrineExtensionsBundle) and use [annotations](https://github.com/Atlantic18/DoctrineExtensions/tree/master/doc/).

> ``git commit -m "add extensions doctrine"``

- Add [fixtures doctrines](http://symfony.com/doc/current/bundles/DoctrineFixturesBundle/index.html) and [faker](http://symfony.com/doc/current/bundles/DoctrineFixturesBundle/index.html). Create [fixture class](http://symfony.com/doc/current/bundles/DoctrineFixturesBundle/index.html#using-the-container-in-the-fixtures).

> ``git commit -m "add fixtures doctrine"``

Create working base
-------------------

- Generate [CRUD files](http://symfony.com/doc/current/bundles/SensioGeneratorBundle/commands/generate_doctrine_crud.html) (controllers, forms, views) by running ``php app/console doctrine:generate:crud`` with [this overrided skeleton](...).
- Add static pages as ``/contact`` or ``/info``.
