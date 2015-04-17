ConsoleBundle
=============

``composer.json`` :
```json
"coresphere/console-bundle": "dev-master"
```
```yml
# app/config/routing_dev.yml
_console:
    resource: "@CoreSphereConsoleBundle/Resources/config/routing.yml"
    prefix: /_console
```
```php
// app/AppKernel.php
$bundles[] = new CoreSphere\ConsoleBundle\CoreSphereConsoleBundle();
```
- run ``assets:install``
- enable ``framework.translator`` in ``app/config/config.yml``

[CoreSphere/ConsoleBundle](https://github.com/CoreSphere/ConsoleBundle)