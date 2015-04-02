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
