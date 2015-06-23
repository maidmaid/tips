Pagination
==========

```php
// src/AppBundle/Entity/OrderRepository.php
use Doctrine\ORM\Tools\Pagination\Paginator;

public function findAllByPage($page = null, $maxResults = 20)
{
    $qb = $this->createQueryBuilder('e');
    
	if ($page) {
        $qb->setFirstResult($maxResults * ($page - 1))->setMaxResults($maxResults);
        $entities = new Paginator($qb, $fetchJoinCollection = true);
        // $entities->setUseOutputWalkers(false); // better perfs if big data
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
    $maxResults = 20;
    
    $entities = $this->getDoctrine()->getManager()->getRepository('AppBundle:Entity')->findAllByPage($page, $maxResults);
    $pages = ceil($entities->count() / $maxResults);
    
    return $this->render(':Entity:index.html.twig', array(
		'entities' => $entities,
		'page' => $page,
		'pages' => $pages
	));
}
```

```php
// examples of findAllByPage($page = null, $maxResults = 20)
$entities = $repository->findAllByPage(); 		// all entities
$entities = $repository->findAllByPage(1); 		// 20 entities of page 1
$entities = $repository->findAllByPage(2);		// 20 entities of page 2
$entities = $repository->findAllByPage(1, 10);	// 10 entities of page 1
$entities = $repository->findAllByPage(2, 10);	// 10 entities of page 2
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
