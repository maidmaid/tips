```php
var_dump((bool) null);           // bool(false)
var_dump((bool) new stdClass()); // bool(true)

var_dump((bool) array());       // bool(false)
var_dump((bool) array(12));     // bool(true)

var_dump((bool) "");            // bool(false)
var_dump((bool) "foo");         // bool(true)
```
