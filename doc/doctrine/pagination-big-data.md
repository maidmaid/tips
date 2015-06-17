Pagination with big data
========================

Queries on 10'000 main entities and 300'000 joined sub-entities :

![Queries on 10'000 main entities and 300'000 joined sub-entities](paginator-with-big-data.png)

- *Query 2* : Perform a Count query using DISTINCT keyword.
- *Query 4* : Perform a Limit Subquery with DISTINCT to find all ids of the entity in from on the current page.
- *Query 5* : Perform a WHERE IN query to get all results for the current page.

[Doc](http://doctrine-orm.readthedocs.org/en/latest/tutorials/pagination.html)

__Solution 1__ : join only one-to-one entites and use ``Paginator`` with ``$fetchJoinCollection`` defined to ``false`` :
 
```php
$entities = new Paginator($query, $fetchJoinCollection = false);
```

__Solution 2__ : don't use output walkers in paginator instance :

```php
$entities = new Paginator($query, $fetchJoinCollection = true);
$entities->setUseOutputWalkers(false);
```
