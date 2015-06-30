# Command with list of args

```sh
# A) Using argument
php app/console cmd fb instgram

# B) Using option
php app/console cmd --scope fb --scope instgram
php app/console cmd -s fb -s instgram

# C) Using option splitted by comma
php app/console cmd --scope fb,instgram
php app/console cmd -s fb,instgram
```

## A) Using argument

```php
// in configure method
$this
    ->setName('cmd')
    ->addArgument('scope', InputArgument::IS_ARRAY, 'Split process by scope', array('fb', 'instgrm', 'tw'));

// in execute method
$scopes = $input->getArgument('scope');
```

## B) Using option

```php
// in configure method
$this
    ->setName('cmd')
    ->addOption('scope', 's', InputOption::VALUE_IS_ARRAY, 'Split process by scope', array('fb', 'instgrm', 'tw'));

// in execute method
$scopes = $input->getArgument('scope');
```

## C) Using option splitted by comma

```php
// in configure method
$this
    ->setName('cmd')
    ->addOption('scope', 's', InputOption::VALUE_REQUIRED, 'Split process by scope', 'fb,instgrm,tw');

// in execute method
$scopes = explode(',', $input->getArgument('scope'));
```
