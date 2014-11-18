[ConsoleBundle](https://github.com/CoreSphere/ConsoleBundle)
===============

Installation
------------

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

[Pagination with ``Paginator`` of Doctrine](http://doctrine-orm.readthedocs.org/en/latest/tutorials/pagination.html)
===========================================

```php
// src/AppBundle/AppController.php

/**
 * @Route("/orders/{page}", name="orders", requirements={"page" = "\d+"}, defaults={"page" = 1})
 */
public function indexAction($page)
{   
    $ordersSize = 10;
    $repository = $this->getDoctrine()->getManager()->getRepository('AppBundle:Order');
    $orders = $repository->findAll($page, $ordersSize);
    $pages = ceil($orders->count() / $ordersSize);
    return $this->render($template, array(
		'orders' => $orders,
		'pages' => $pages,
		'page' => $page
	));
}
```
