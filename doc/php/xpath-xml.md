XPath query in XML file
-----------------------

```php
<?php

$document = new \DomDocument();
$document->load('https://httpbin.org/xml');
$xpath = new \DOMXpath($document);

$titles = $xpath->query('/slideshow/slide/title');
foreach ($titles as $title) {
    /** @var DOMNode $title */
    echo $title->nodeValue."\n";
}
```
