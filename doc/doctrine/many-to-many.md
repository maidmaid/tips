Many-To-Many, Unidirectional, with attributes
=============================================

```php
class A
{
    /** @ORM\OneToMany(targetEntity="AB", mappedBy="a", cascade={"all"}) */
    private $abs;
}
```
```php
class B
{
    /** @ORM\OneToMany(targetEntity="AB", mappedBy="b", cascade={"all"}) */
    private $abs;
}
```
```php
class AB
{
    /** @ORM\ManyToOne(targetEntity="A", inversedBy="abs") */
    private $a;

    /** @ORM\ManyToOne(targetEntity="B", inversedBy="abs") */
    private $b;
}
```

## Problem with bidirectionnel persistance

### Problem

```php
$ab = new AB();
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
        $this->ab[] = $ab;
        $ab->setA($this); // add this
    }
}
```
