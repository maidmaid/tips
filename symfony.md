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

Access ``app_dev.php`` from domain
==================================

Use ``gethostbyname('domain')`` in exit condition :
```php
// web/app_dev.php
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

Forms
=====

```twig
{# form_widget: display all fields with errors #}
<form method="POST" {{ form_enctype(form) }}>
	{{ form_widget(form) }}
	<input type="submit" />
</form>
```
```twig
{# form_row: display field by field #}
<form method="POST" {{ form_enctype(form) }}>
	{{ form_errors(form) }}
	{{ form_row(form.start) }}
	{{ form_row(form.end) }}
	{{ form_rest(form) }}
	<input type="submit" />
</form>
```
```twig
{# use entity via form #}
{{ form.start.vars.value }}						-> (string) 2014-11-25
{{ form.start.vars.data }}						-> (DateTime) object
{{ form.start.vars.data|date('Y-m-d H:m:s') }}	-> (string) 2014-11-25 15:13:00
```
