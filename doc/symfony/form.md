Forms
=====

```twig
{# form_widget: display all fields with errors #}

{{ form_start(form, {'attr': {'class': 'my-form-class'} }) }}
    {{ form_widget(form) }}
{{ form_end(form) }}
```

```twig
{# form_row: display field by field #}

{{ form_start(form) }) }}
    {{ form_errors(form) }}
	{{ form_row(form.start) }}
	{{ form_row(form.end) }}
{{ form_end(form) }}
```

```twig
{# use entity via form #}

{{ form.start.vars.value }}						-> (string) 2014-11-25
{{ form.start.vars.data }}						-> (DateTime) object
{{ form.start.vars.data|date('Y-m-d H:m:s') }}	-> (string) 2014-11-25 15:13:00
```
