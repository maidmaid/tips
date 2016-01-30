<?php

namespace Maidmaid;

require __DIR__.'/vendor/autoload.php';

use Symfony\Component\Serializer\Encoder\DecoderInterface;
use Symfony\Component\Serializer\Encoder\EncoderInterface;
use Symfony\Component\Serializer\Normalizer\DenormalizerInterface;
use Symfony\Component\Serializer\Normalizer\NormalizerInterface;
use Symfony\Component\Serializer\Serializer;

class MyNormalizer implements NormalizerInterface, DenormalizerInterface
{
    public function normalize($object, $format = null, array $context = array())
    {
        return $object.'+normalize';
    }

    public function supportsNormalization($data, $format = null)
    {
        return true;
    }

    public function denormalize($data, $class, $format = null, array $context = array())
    {
        return $data.'+denormalize';
    }

    public function supportsDenormalization($data, $type, $format = null)
    {
        return true;
    }
}

class MyEncoder implements EncoderInterface, DecoderInterface
{
    public function encode($data, $format, array $context = array())
    {
        return $data.'+encode';
    }

    public function supportsEncoding($format)
    {
        return true;
    }

    public function decode($data, $format, array $context = array())
    {
        return $data.'+decode';
    }

    public function supportsDecoding($format)
    {
        return true;
    }
}

$serializer = new Serializer(array(new MyNormalizer()), array(new MyEncoder()));

echo 'Serialization: '.$serializer->serialize('data', '').PHP_EOL;
echo 'Deserialization: '.$serializer->deserialize('data', null, '').PHP_EOL;

/* Output:
Serialization: data+normalize+encode
Deserialization: data+decode+denormalize
*/
