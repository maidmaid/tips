Pagination
==========

```php
// src/AppBundle/Entity/OrderRepository.php
use Doctrine\ORM\Tools\Pagination\Paginator;

public function findAllByPage($page = 1, $maxResults = 20)
{
    $qb = $this->createQueryBuilder('e');
    
    // Use paginator if limit is defined
    if ($page !== null && $maxResults !== null) {
	    $qb->setFirstResult($maxResults * ($page - 1))->setMaxResults($maxResults);
	    $entities = new Paginator($qb->getQuery(), $fetchJoinCollection = false);
	} else {
	    $entities = $qb->getQuery()->getResult();
	}
    
    return $entities;
}
```

```php
// src/AppBundle/AppController.php
/**
 * @Route("/entities/{page}", name="entities", requirements={"page" = "\d+"}, defaults={"page" = 1})
 */
public function indexAction($page)
{
    $repository = $this->getDoctrine()->getManager()->getRepository('AppBundle:Entity');
    $maxResults = 20;
    
    $entities = $repository->findAllByPage($page, $maxResults);
    $pages = ceil($orders->count() / $maxResults);
    
    return $this->render(':Entity:index.html.twig', array(
		'entities' => $entities,
		'page' => $page,
		'pages' => $pages
	));
}
```

```php
// examples of findAllByPage()
$entities = $repository->findAllByPage(); 			// 20 entities of page 1
$entities = $repository->findAllByPage(1); 			// 20 entities of page 1
$entities = $repository->findAllByPage(2);			// 20 entities of page 2
$entities = $repository->findAllByPage(1, 10);		// 10 entities of page 1
$entities = $repository->findAllByPage(2, 10);		// 20 entities of page 2
$entities = $repository->findAllByPage(null, null);	// all entities
```

```twig
{# app/Resources/views/Entity/index.html.twig (bootstrap version) #}
{% for entity in entities %}
    <p>{{ entity.name }}</p>
{% endfor %}
<nav>
    <ul class="pagination">
        {% for p in 1..pages %}
        <li class="{% if p == page %}active{% endif %}">
            <a href="{{ path('entities', { page: p }) }}">{{ p }}</a>
        </li>
        {% endfor %}
    </ul>
</nav>
```

[Doc](http://doctrine-orm.readthedocs.org/en/latest/tutorials/pagination.html)
