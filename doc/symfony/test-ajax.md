Test ajax request
=================

```php
public function testAjax()
{
    $this->requestWithAdmin('GET', '/', array(), array(), array('HTTP_X-Requested-With' => 'XMLHttpRequest');
    $this->assertTrue($this->client->getResponse()->isSuccessful());
}
```
