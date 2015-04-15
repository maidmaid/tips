Tips for doctrine extensions
============================

Uploadable example
-------------------
```
# app/config/config.yml
stof_doctrine_extensions:
    orm:
        default:
            uploadable: true
    uploadable:
        default_file_path: %kernel.root_dir%/../web/uploads
```
```php
// src/AppBundle/Entity/Document.php
use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * @ORM\Table(name="document")
 * @ORM\Entity(repositoryClass="Dl\Lessus\AppBundle\Entity\DocumentRepository")
 * @Gedmo\Uploadable(filenameGenerator="SHA1", allowOverwrite=true, appendNumber=true)
 */
class Document
{
    /** @ORM\Column(name="id", type="integer") @ORM\Id @ORM\GeneratedValue(strategy="AUTO") */
    private $id;

    /**
     * @var string
     *
     * @ORM\Column(name="file_path", type="string", length=255)
     * @Gedmo\UploadableFilePath
     */
    private $filePath;

    /**
     * @var string
     *
     * @ORM\Column(name="file_name", type="string", length=255)
     * @Gedmo\UploadableFileName
     */
    private $fileName;

    /**
     * @Assert\File()
     */
    public $file;

    // Setters, getters...

    /**
     * Get web path.
     *
     * @return null|string
     */
    public function getWebPath()
    {
        return null === $this->fileName ? null : 'uploads/'.$this->fileName;
    }
}
```
```php
// src/AppBundle/Form/DocumentType.php 
 public function buildForm(FormBuilderInterface $builder, array $options)
 {
      $builder
          ->add('file', 'file', array(
              'data_class' => null,
              'required' => false,
          ))
      ;
 }
 ```
```php
// src/AppBundle/Controller/DocumentController.php
public function editAction(Request $request, Document $document)
{
    //...
    if ($editForm->isValid()) {
        $uploadableManager = $this->container->get('stof_doctrine_extensions.uploadable.manager');
            if ($document->file instanceof UploadedFile) {
                $uploadableManager->markEntityToUpload($document, $document->file);
            }
        }
        //...
    }
    //...
```
