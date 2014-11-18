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

[Pagination with ``Paginator`` of Doctrine](http://doctrine-orm.readthedocs.org/en/latest/tutorials/pagination.html)
===========================================

```php
// src/AppBundle/Entity/OrderRepository.php
use Doctrine\ORM\Tools\Pagination\Paginator;

public function findAll($page = 1, $maxResults = 20)
{
    $query = $this->createQueryBuilder('o')
        ->setFirstResult($maxResults * ($page - 1))
        ->setMaxResults($maxResults);
    $orders = new Paginator($query, $fetchJoinCollection = true);
    
    return $orders;
}
```
```php
// src/AppBundle/AppController.php
/**
 * @Route("/orders/{page}", name="orders", requirements={"page" = "\d+"}, defaults={"page" = 1})
 */
public function indexAction($page)
{
    $maxResults = 20;
    $repository = $this->getDoctrine()->getManager()->getRepository('AppBundle:Order');
    $orders = $repository->findAll($page, $maxResults);
    $pages = ceil($orders->count() / $maxResults);
    return $this->render(':Order:index.html.twig', array(
		'orders' => $orders,
		'pages' => $pages,
		'page' => $page
	));
}
```
```twig
{# app/Resources/views/Order/index.html.twig (bootstrap version) #}
<nav>
    <ul class="pagination">
        {% for p in 1..pages %}
        <li class="{% if p == page %}active{% endif %}">
            <a href="{{ path('oz_tpf_orders', { page: p }) }}">{{ p }}</a>
        </li>
        {% endfor %}
    </ul>
</nav>
```
