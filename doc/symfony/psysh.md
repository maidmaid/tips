Test ajax request
=================

```php
public function testAjax()
{
    $client = static::createClient();
    $client->request('GET', '/', array(), array(), array('HTTP_X-Requested-With' => 'XMLHttpRequest');
    $this->assertTrue($this->client->getResponse()->isSuccessful());
}
```
