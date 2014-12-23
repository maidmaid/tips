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
		'page' => $page,
		'pages' => $pages
	));
}
```
```twig
{# app/Resources/views/Order/index.html.twig (bootstrap version) #}
{% for order in orders %}
    <p>{{ order.name }}</p>
{% endfor %}
<nav>
    <ul class="pagination">
        {% for p in 1..pages %}
        <li class="{% if p == page %}active{% endif %}">
            <a href="{{ path('orders', { page: p }) }}">{{ p }}</a>
        </li>
        {% endfor %}
    </ul>
</nav>
```

Flashbag
========
```php
// AppController.php
$this->get('session')->getFlashBag()->add('success', 'Ok!');
```
```twig
{# boostrap version #}
<div class="container">	
    {% for type, messages in app.session.flashbag.all() %}
    <div class="alert alert-{{ type }}">
        <div class="panel-body">
            {% for message in messages %}
            <p>{{ message|trans|raw }}</p>
            {% endfor %}
        </div>
    </div>
    {% endfor %}
</div>
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
	{{ form_row(form._token) }}
	{{ form_row(form.start) }}
	{{ form_row(form.end) }}
	<input type="submit" />
</form>
```
```twig
{# use entity via form #}
{{ form.start.vars.value }}						-> (string) 2014-11-25
{{ form.start.vars.data }}						-> (DateTime) object
{{ form.start.vars.data|date('Y-m-d H:m:s') }}	-> (string) 2014-11-25 15:13:00
```

Doctrine: Many-To-Many, Unidirectional, with attributes
=======================================================

```php
class A
{
    /**
     * @var AB[]
     * 
     * @ORM\OneToMany(targetEntity="AB", mappedBy="a", cascade={"all"})
     */
    private $abs;
}
```
```php
class B
{
    /**
     * @var AB[]
     * 
     * @ORM\OneToMany(targetEntity="AB", mappedBy="b", cascade={"all"})
     */
    private $abs;
}
```
```php
class AB
{
    /**
     * @var A
     *
     * @ORM\ManyToOne(targetEntity="A", inversedBy="abs")
     */
    private $a;

    /**
     * @var B
     *
     * @ORM\ManyToOne(targetEntity="B", inversedBy="abs")
     */
    private $b;
}
```

### Problem with bidirectionnel persistance

#### Problem 1

```php
$a->addAB($ab);
$em->persist($a);
$em->flush();
```

Table AB

| id | a_id   | b_id |
|----|--------|------|
| 1  | `NULL` | 1    |

Resolution :

```php
class A
{
    public function addAB(AB $ab)
    {
    	//...
        $ab->setA($this);
		//...
    }
}
```

#### Problem 2

```php
$ab->setA($a);
$em->persist($a);
$em->flush();
```

Table AB

| id     | a_id   | b_id   |
|--------|--------|--------|
| `NULL` | `NULL` | `NULL` |

Resolution :

```php
class AB
{
	public function setA(A $a)
    {
        //...
        $a->addAB($this);
        //...
    }
}
```

Others
======

Use ajax with bootstrap popover
-------------------------------

```twig
{# index.html.twig #}
<div
	class="my-popover"
	data-toggle="popover"
	data-placement="top"
	data-container="body"
	data-trigger="click"
	data-html="true"
	data-title="..."
	data-url="{{ path('my_route') }}"
>Click-me!</div>
<script>
	$('.my-popover').click(function(){
		var $e = $(this);
		$e.popover({content: '...'}).popover('show');
		$.get($e.data('url'), function(data){
			$e.unbind('click');
			$e.popover('destroy').popover({content: data}).popover('show');
		});
	});
</script>
```
```php
// AppController.php
/**
 * @Route("/myroute", name="my_route")
 */
public function myRouteAction(Request $request)
{
	if(!$request->isXmlHttpRequest()) {
		throw $this->createAccessDeniedException();
	}
	//...
    return $this->render('::popover.html.twig');
}
```
