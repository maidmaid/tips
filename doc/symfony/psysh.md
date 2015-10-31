Psysh
=====

Script that debug sf project.

```php
require_once 'app/bootstrap.php.cache';
require_once 'app/AppKernel.php';

$k = new \AppKernel('dev', true);
$k->loadClassCache();
$k->boot();

$c = $k->getContainer();

$em = $c->get('doctrine')->getManager();
//
```
