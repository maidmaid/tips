Pagination
==========

```php
// src/AppBundle/Entity/OrderRepository.php
use Doctrine\ORM\Tools\Pagination\Paginator;

public function findAllByPage($page = 1, $maxResults = 20)
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
    $repository = $this->getDoctrine()->getManager()->getRepository('AppBundle:Order');
    $maxResults = 20;
    
    $orders = $repository->findAllByPage($page, $maxResults);
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

[Doc](http://doctrine-orm.readthedocs.org/en/latest/tutorials/pagination.html)
