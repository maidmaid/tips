Require vendor/autoload.php in bin php file
===========================================

The location of bin php file can be ``bin/my-bin`` or ``vendor/my-vendor/my-package/bin/my-bin``.

```php
#!/usr/bin/env php
<?php

require file_exists(__DIR__.'/../vendor/autoload.php')
    ? __DIR__.'/../vendor/autoload.php'
    : __DIR__.'/../../../autoload.php';
```

Examples :

[symfony installer](https://github.com/symfony/symfony-installer/blob/master/symfony#L17-L19),
[composer](https://github.com/composer/composer/blob/master/src/bootstrap.php#L13-L25),
[doctrine](https://github.com/doctrine/doctrine2/blob/master/bin/doctrine.php#L23-L31),
[phpunit](https://github.com/sebastianbergmann/phpunit/blob/master/phpunit#L25-L31),
[php cs fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer/blob/1.12/php-cs-fixer#L34-L39),
[phpbench](https://github.com/phpbench/phpbench/blob/master/bin/phpbench.php#L12-L20),
[symfony deprecation detector](https://github.com/sensiolabs-de/deprecation-detector/blob/master/bin/deprecation-detector#L4-L11),
[psysh](https://github.com/bobthecow/psysh/blob/master/bin/psysh#L86-L94),
[blackfire player](https://github.com/blackfireio/player/blob/master/bin/blackfire-player.php#L14-L20),
[phpspec](https://github.com/phpspec/phpspec/blob/master/bin/phpspec#L6-L23)
