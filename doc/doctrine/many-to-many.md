Many-To-Many, Unidirectional, with attributes
=============================================

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

## Problem with bidirectionnel persistance

### Problem 1

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

### Problem 2

```php
$ab->setA($a);
$em->persist($a);
$em->flush();
```

Table AB

| id     | a_id   | b_id   |
|--------|--------|--------|
| `NULL` | `NULL` | `NULL` |

## Resolution

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