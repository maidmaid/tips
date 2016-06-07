Override form
=============

In reusable bundle
------------------

Create a form type:

```php
// vendor/vendor/package/Form/MyType.php

class MyType extends AbstractType
{
    public function getName()
    {
        return 'vendor_package_mytype';
    }
}
```

Define a form type param, a form type service and form service that uses form type param:

```yml
# vendor/vendor/package/Resources/config/services.yml

parameters:
    vendor_package.my.form.type: vendor_package_mytype

services:
    vendor_package.my.form.type:
        class: Vendor\PackageBundle\Form\MyType
        tags:
            - { name: form.type, alias: vendor_package_mytype }

    vendor_package.my.form:
        class: Symfony\Component\Form\Form
        factory: ["@form.factory", "createNamed"]
        arguments:
            - "vendor_package_mytype"
            - "%vendor_package.my.form.type%"
```

Use form service in controller:

```php
// vendor/vendor/package/Controller/MyController.php

class MyController extends Controller
{
    /**
     * @Route("/my", name="vendor_package_my")
     */
    public function inscriptionAction(Request $request)
    {
        $form = $this->get('dl_contest.inscription.form')
            ->setData($my = new My())
        ;
    }
}
```

In app bundle
-------------

Create a form type that implements ``getParent()``:

```php
// src/AppBundle/Form/MyType.php

class MyType extends AbstractType
{
    public function getName()
    {
        return 'app_mytype';
    }

    public function getParent()
    {
        return 'vendor_package_mytype';
    }
}
```

Override form type param with the new form type service:

```yml
# app/config/services.yml

parameters:
    vendor_package.my.form.type: app_mytype

services:
    app.inscription.form.type:
        class: AppBundle\Form\MyType
        tags:
            - { name: form.type, alias: app_mytype }
```
