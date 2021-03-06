Symfony best practices
======================

[Official doc](http://symfony.com/doc/current/best_practices)

Creating the project
--------------------

### Application Bundles

- Create only one bundle called ``AppBundle`` for your application logic
- There is no need to prefix the ``AppBundle`` with your own vendor (e.g. ``AcmeAppBundle``), because this application bundle is never going to be shared.

Configuration
-------------

- **Infrastructure-Related Configuration** : Define the infrastructure-related configuration options in the ``app/config/parameters.yml`` file.
- **Canonical Parameters** : Define all your application's parameters in the ``app/config/parameters.yml.dist`` file.
- **Application-Related Configuration** : Define the application behavior related configuration options in the ``app/config/config.yml`` file.
- **Constants vs Configuration Options** :  Use constants to define configuration options that rarely change.
- **Semantic Configuration: Don't Do It** : Don't define a semantic dependency injection configuration for your bundles.

Organizing Your Business Logic
------------------------------

- **Storing Classes Outside of the Bundle?** : The recommended approach of using the ``AppBundle`` directory is for simplicity. If you're advanced enough to know what needs to live in a bundle and what can live outside of one, then feel free to do that.
- **Services: Naming and Format** : The name of your application's services should be as short as possible, ideally just one simple word.
- **Service Format: YAML** : Use the YAML format to define your own services.
- **Service: No Class Parameter** : Don't define parameters for the classes of your services.
- **Using a Persistence Layer** : If you're more advanced, you can of course store them under your own namespace in ``src/``.
- **Doctrine Mapping Information** : Use annotations to define the mapping information of the Doctrine entities.
- **Data Fixtures** : We recommend creating just one fixture class for simplicity, though you're welcome to have more if that class gets quite large.
- **Coding Standards** : The Symfony source code follows the PSR-1 and PSR-2 coding standards that were defined by the PHP community

Controllers
-----------

- Make your controller extend the ``FrameworkBundle`` base Controller and use annotations to configure routing, caching and security whenever possible.
- **Routing Configuration** : To load routes defined as annotations in your controllers.
```yml
# app/config/routing.yml
app:
    resource: "@AppBundle/Controller/"
    type:     annotation
```
```php
namespace AppBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;

class DefaultController extends Controller
{
    /**
     * @Route("/", name="homepage")
     */
    public function indexAction()
    {
        // ...
    }
}
```
- **Template Configuration** : Don't use the ``@Template()`` annotation to configure the template used by the controller.
- **Using the ParamConverter** : Use the ParamConverter trick to automatically query for Doctrine entities when it's simple and convenient.
```php
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\ParamConverter;

/**
 * @Route("/comment/{postSlug}/new", name = "comment_new")
 * @ParamConverter("post", options={"mapping": {"postSlug": "slug"}})
 */
public function newAction(Request $request, Post $post)
{
    // ...
}
```

Templates
---------

- Use Twig templating format for your templates.
- **Template Location** : Store all your application's templates in ``app/Resources/views/`` directory. Use lowercased snake_case for directory and template names.
- **Twig Extensions** : Define your Twig extensions in the ``AppBundle/Twig/`` directory and configure them using the ``app/config/services.yml`` file.

Forms
-----

- Define your forms as PHP classes.
- **Form Button Configuration** : Add buttons in the templates, not in the form classes or the controllers.
```twig
{{ form_start(form) }}
    {{ form_widget(form) }}
    <input type="submit" value="Create" class="btn btn-default pull-right" />
{{ form_end(form) }}
```
- **Rendering the Form** : Don't use the ``form()`` or ``form_start()`` functions to render the starting and ending form tags.
The exception is a delete form because it's really just one button and so benefits from some of these extra shortcuts.
- **Handling Form Submits** : We recommend that you use a single action for both rendering the form and handling the form submit. We recommend using ``$form->isSubmitted()`` in the if statement for clarity.
```php
public function newAction(Request $request)
{
    // build the form ...

    $form->handleRequest($request);

    if ($form->isSubmitted() && $form->isValid()) {
        $em = $this->getDoctrine()->getManager();
        $em->persist($post);
        $em->flush();

        return $this->redirect($this->generateUrl(
        	'admin_post_show',
            array('id' => $post->getId())
        ));
    }

    // render the template
}
```
- **Custom Form Field Types** : Add the app_ prefix to your custom form field types to avoid collisions.

Internationalization
--------------------

- Uncomment the following translator configuration option and set your application locale.
```yml
# app/config/parameters.yml
parameters:
    # ...
    locale:     en
```
```yml
# app/config/config.yml
framework:
    # ...
    translator: { fallback: "%locale%" }
```
- **Translation Source File Format** : Use the XLIFF format for your translation files.
- **Translation Source File Location** : Store the translation files in the ``app/Resources/translations/`` directory.
- **Translation Keys** : Always use keys for translations instead of content strings.
```xml
<!-- app/Resources/translations/messages.en.xliff -->
<?xml version="1.0"?>
<xliff version="1.2" xmlns="urn:oasis:names:tc:xliff:document:1.2">
    <file source-language="en" target-language="en" datatype="plaintext">
        <body>
            <trans-unit id="1">
                <source>title.post_list</source>
                <target>Post List</target>
            </trans-unit>
        </body>
    </file>
</xliff>
```

Security
--------

### Authentication and Firewalls (i.e. Getting the User's Credentials)

- Unless you have two legitimately different authentication systems and users (e.g. form login for the main site and a token system for your API only), we recommend having only one firewall entry with the anonymous key enabled.
- Use the ``bcrypt`` encoder for encoding your users' passwords.
- The source code for our project contains comments that explain each part.

### Authorization (i.e. Denying Access)

- For protecting broad URL patterns, use ``access_control``;
- Whenever possible, use the ``@Security`` annotation;
- Check security directly on the ``security.context`` service whenever you have a more complex situation.
- For fine-grained restrictions, define a custom security voter;
- For restricting access to any object by any user via an admin interface, use the Symfony ACL.

**The @Security Annotation** : 
```php
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;

/**
 * @Route("/new", name="admin_post_new")
 * @Security("has_role('ROLE_ADMIN')")
 */
public function newAction()
{
    // ...
}
```

Web Assets
----------

- Store your assets in the ``web/`` directory.
```twig
<link rel="stylesheet" href="{{ asset('css/bootstrap.min.css') }}" />
```
- Keep in mind that web/ is a public directory and that anything stored here will be publicly accessible. For that reason, you should put your compiled web assets here, but not their source files (e.g. SASS files).
- **Using Assetic** : Use Assetic to compile, combine and minimize web assets, unless you're comfortable with frontend tools like GruntJS.
```twig
{% stylesheets
    'css/bootstrap.min.css'
    'css/main.css'
    filter='cssrewrite' output='css/compiled/all.css' %}
    <link rel="stylesheet" href="{{ asset_url }}" />
{% endstylesheets %}

{% javascripts
    'js/jquery.min.js'
    'js/bootstrap.min.js'
    output='js/compiled/all.js' %}
    <script src="{{ asset_url }}"></script>
{% endjavascripts %}
```

Tests
-----

- **Functional Tests** : Define a functional test that at least checks if your application pages are successfully loading.
- **Hardcode URLs in a Functional Test** : Hardcode the URLs used in the functional tests instead of using the URL generator.
