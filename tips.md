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

Access ``app_dev.php`` from domain
==================================

Use ``gethostbyname('domain')`` in exit condition in ``web/app_dev.php`` :
```php
if (isset($_SERVER['HTTP_CLIENT_IP'])
    || isset($_SERVER['HTTP_X_FORWARDED_FOR'])
    || !(in_array(@$_SERVER['REMOTE_ADDR'], array(
        '127.0.0.1', 
        'fe80::1', 
        '::1', 
        gethostbyname('opointzero.dyndns.org'))) 
    || php_sapi_name() === 'cli-server')
)
```
