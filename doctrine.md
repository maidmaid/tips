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

Pagination
==========

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

[Doc](http://doctrine-orm.readthedocs.org/en/latest/tutorials/pagination.html)

Pagination with big data
------------------------

Queries on 10'000 main entities and 300'000 joined sub-entities :

![Queries on 10'000 main entities and 300'000 joined sub-entities](/img/doctrine/paginator-with-big-data.png)

- *Query 2* : Perform a Count query using DISTINCT keyword.
- *Query 4* : Perform a Limit Subquery with DISTINCT to find all ids of the entity in from on the current page.
- *Query 5* : Perform a WHERE IN query to get all results for the current page.

[Doc](http://doctrine-orm.readthedocs.org/en/latest/tutorials/pagination.html)

Solution : use only *one-to-one* joins with :
 
```php
$entities = new Paginator($query, $fetchJoinCollection = false);
```
