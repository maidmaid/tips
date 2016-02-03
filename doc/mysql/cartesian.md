Cartesian product with intermediate table
=========================================

```
+-----+     +-----------------+     +-----+             +-----------------+
|  X  +-----+       XY        +-----+  Y  |             |       XY        |
+-----+     +-----+-----+-----+     +-----+             +-----+-----+-----+
| id  |     | id  |  X  |  Y  |     | id  |             | id  |  X  |  Y  |
+-----+     +-----------------+     +-----+  +------->  +-----------------+
|  1  |     |  5  |  1  |  9  |     |  9  |             |  5  |  1  |  9  |
|  2  |     |     |     |     |     |     |             | NULL|  2  |  9  |
|  3  |     |     |     |     |     |     |             | NULL|  3  |  9  |
+-----+     +-----+-----+-----+     +-----+             +-----------+-----+
```

Formula: ``XY ∪ X×Y-XY``

SQL:

```sql
SELECT * FROM xy
UNION
SELECT NULL as id, x.id, y.id FROM x, y WHERE (x.id, y.id) NOT IN (SELECT x, y FROM xy)
```

3 steps in detail : ``XY* ∪ X×Y**-XY***``
  1. ``SELECT * FROM xy``
  2. ``UNION SELECT NULL as id, x.id, y.id FROM x, y``
  3. ``WHERE (x.id, y.id) NOT IN (SELECT x, y FROM xy)``

```
1)                      2)                      3)
+-----------------+     +-----------------+     +-----------------+
|       XY        |     |       XY        |     |       XY        |
+-----+-----+-----+     +-----+-----+-----+     +-----+-----+-----+
| id  |  X  |  Y  |     | id  |  X  |  Y  |     | id  |  X  |  Y  |
+-----------------+     +-----------------+     +-----------------+
|  5  |  1  |  9  |     |  5  |  1  |  9  |     |  5  |  1  |  9  |
|     |     |     |     | NULL|  1  |  9  |     | NULL|  2  |  9  |
|     |     |     |     | NULL|  2  |  9  |     | NULL|  3  |  9  |
|     |     |     |     | NULL|  3  |  9  |     |     |     |     |
+-----+-----+-----+     +-----------+-----+     +-----+-----+-----+
```

If you want filter result for y = 9 :

```sql
SELECT * FROM xy WHERE xy.y = 9
UNION
SELECT NULL as id, x.id, y.id FROM x, y
  WHERE (x.id, y.id) NOT IN (SELECT x, y FROM xy AND xy.y = 9) AND y.id = 9
```
