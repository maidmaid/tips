<?php

require '/usr/local/bin/psysh';
require 'app/autoload.php';
require 'app/AppKernel.php';

$kernel = new \AppKernel('dev', true);
$kernel->boot();

extract(\Psy\Shell::debug([
    'k' => $kernel,
    'c' => $kernel->getContainer(),
    'p' => $kernel->getContainer()->getParameterBag()->all(),
    'em' => $kernel->getContainer()->get('doctrine')->getManager(),
]));
