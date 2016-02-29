Locales in sf app
=================

In ``app/config/parameters.yml`` file :

```yml
parameters:
    app_locales: fr|de
```

In ``app/config/config.yml`` file :

```yml
twig:
    globals:
        locales: %app_locales%
```

In ``app/Resources/views/locales.yml`` file :

```twig
{% for locale in locales|split('|') %}
    {% set route = app.request.get('_route')|default('homepage') %}
    {% set params = app.request.get('_route_params')|default({})|merge({'_locale': locale}) %}
    <a href="{{ path(route, params) }}"
       title="{{ locale }}"
       class="{% if locale == app.request.locale %}current{% endif %}">
       {{ locale|upper }}
    </a>
    {% if not loop.last %}|{% endif %}
{% endfor %}
```