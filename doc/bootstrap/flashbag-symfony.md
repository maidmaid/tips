Flashbag's Symfony
==================

```twig
<div class="container">	
    {% for type, messages in app.session.flashbag.all() %}
    <div class="alert alert-{{ type }}">
        {% for message in messages %}
        <p>{{ message|trans|raw }}</p>
        {% endfor %}
    </div>
    {% endfor %}
</div>
```
