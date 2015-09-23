```php
var_dump((bool) null);           // bool(false)
var_dump((bool) new stdClass()); // bool(true)

var_dump((bool) array());        // bool(false)
var_dump((bool) array(12));      // bool(true)

var_dump((bool) "");             // bool(false)
var_dump((bool) "foo");          // bool(true)

// Check isset and value
$a = array();
$a[0] == 'a';                   // PHP error:  Undefined offset: 0 on line 1
isset($a[0]) && $a[0] == 'a';   // false
```
