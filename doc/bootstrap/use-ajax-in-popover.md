Use ajax in Popover
===================

```twig
{# index.html.twig #}
<div
	class="my-popover"
	data-toggle="popover"
	data-placement="top"
	data-container="body"
	data-trigger="click"
	data-html="true"
	data-title="..."
	data-url="{{ path('my_route') }}"
>Click-me!</div>
<script>
	$('.my-popover').click(function(){
		var $e = $(this);
		$e.popover({content: '...'}).popover('show');
		$.get($e.data('url'), function(data){
			$e.unbind('click');
			$e.popover('destroy').popover({content: data}).popover('show');
		});
	});
</script>
```

```php
// AppController.php
/**
 * @Route("/myroute", name="my_route")
 */
public function myRouteAction(Request $request)
{
	if(!$request->isXmlHttpRequest()) {
		throw $this->createAccessDeniedException();
	}
	//...
    return $this->render('::popover.html.twig');
}
```