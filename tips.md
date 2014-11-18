[ConsoleBundle](https://github.com/CoreSphere/ConsoleBundle)
===============

Installation
------------

- ``composer.json`` :
```json
"coresphere/console-bundle": "dev-master"
```
- ``app/config/routing_dev.yml`` :
```yml
_console:
    resource: "@CoreSphereConsoleBundle/Resources/config/routing.yml"
    prefix: /_console
```
- ``app/AppKernel.php``
```php
$bundles[] = new CoreSphere\ConsoleBundle\CoreSphereConsoleBundle();
```
- run ``assets:install``
- enable ``framework.translator`` in ``app/config/config.yml``
