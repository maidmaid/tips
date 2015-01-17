Twig loop with rows
-------------------

```twig
{# 4 columns / row for example #}
{% for product in products %}
	{% if loop.index0 % 4 == 0 %}
		<div class="row">
	{% endif %}
	
	<div class="col-md-3">{{ product.name }}</div>
	
	{% if loop.index % 4 == 0 %}
		</div> <!-- end .row -->
	{% endif %}
{% endfor %}
```
