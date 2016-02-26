Cartesian product with intermediate table
=========================================

```
+-----+     +-----------------+     +-----+             +-----------------+
|  X  +-----+       XY        +-----+  Y  |             |       XY        |
+-----+     +-----+-----+-----+     +-----+             +-----+-----+-----+
| id  |     | id  |  x  |  y  |     | id  |             | id  |  x  |  y  |
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

Doctrine usage
--------------

```php
// src/AppBundle/Repository/XYRepository.php
class XYRepository extends EntityRepository
{
    public function findByYAndAllX($y)
    {
        $em = $this->getEntityManager();

        $sql = '
          SELECT id, x, y,
          FROM XY xy
          WHERE xy.y = :y
              UNION
          SELECT -x.id as id, x.id, y.id
          FROM X x, Y y
          WHERE
                (x.id, y.id) NOT IN (SELECT id, x, y, FROM XY xy WHERE xy.y = :y)
                AND y.id = :y
        ';

        $rsm = new ResultSetMappingBuilder($this->getEntityManager());
        $rsm->addRootEntityFromClassMetadata('AppBundle:XY', 'xy');
        $rsm->addEntityResult('AppBundle:XY', 'xy');
        $result = $em->createNativeQuery($sql, $rsm)
            ->setParameter('y', $y)
            ->getResult();

        // Detach entities that don't exist
        array_walk($result, function(XY &$xy) use ($em) {
            if ($xy->getId() < 0) {
                $xy->setId(null);
                $em->detach($xy);
            }
        });

        return $result;
    }
}
```

- Doctrine doesn't hydrate entity with null id, it's why I use ``SELECT -x.id`` and next I set null id for each entity that has a negative id.
- Doctrine consideres as existing an entity that was hydrated, it's why I use ``$em->detach($xy);`` else it's impossible to add this new entities.

```php
// src/AppBundle/Controller/XYsController.php
class XYsController extends Controller
{
    /**
     * @Route("/edit", name="edit")
     * @Method({"GET", "POST"})
     */
    public function editAction(Request $request)
    {
        $em = $this->getDoctrine()->getManager();
        $y = ...;

        $xys = $em->getRepository('AppBundle:XY')->findByYAndAllX($y);
        $editForm = $this->createFormBuilder($data = array('xys' => $xys))
            ->add('xys', CollectionType::class, array('entry_type' => XYType::class))
            ->getForm();

        $editForm->handleRequest($request);

        if ($editForm->isSubmitted() && $editForm->isValid()) {
            foreach ($data['xys'] as $xy) {
                $em->persist($xy);
            }
            $em->flush();
        }

        return $this->render('xys/edit.html.twig', array(
            'xys' => $xys,
            'edit_form' => $editForm->createView(),
        ));
    }
}
```

```php
// src/AppBundle/Form/XYType.php
class XYType extends AbstractType
{
    /** {@inheritdoc} */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('x', 'hidden', array('property_path' => 'x.id'));
    }

    /** {@inheritdoc} */
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(array('data_class' => 'AppBundle\Entity\XY'));
    }
}
```
