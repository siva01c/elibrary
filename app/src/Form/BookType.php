<?php

namespace App\Form;

use App\Entity\Book;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\Length;
use Symfony\Component\Validator\Constraints\NotBlank;
use Symfony\Component\Validator\Constraints\Range;

class BookType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('title', TextType::class, [
                'label' => 'Title',
                'attr' => ['class' => 'form-control'],
                'constraints' => [
                    new NotBlank(['message' => 'Please enter a title']),
                    new Length(['max' => 255, 'maxMessage' => 'Title cannot be longer than {{ limit }} characters']),
                ],
            ])
            ->add('author', TextType::class, [
                'label' => 'Author',
                'attr' => ['class' => 'form-control'],
                'constraints' => [
                    new NotBlank(['message' => 'Please enter an author']),
                    new Length(['max' => 255, 'maxMessage' => 'Author cannot be longer than {{ limit }} characters']),
                ],
            ])
            ->add('isbn', TextType::class, [
                'label' => 'ISBN',
                'required' => false,
                'attr' => ['class' => 'form-control', 'placeholder' => 'e.g., 978-3-16-148410-0'],
                'constraints' => [
                    new Length(['max' => 20, 'maxMessage' => 'ISBN cannot be longer than {{ limit }} characters']),
                ],
            ])
            ->add('publicationYear', IntegerType::class, [
                'label' => 'Publication Year',
                'required' => false,
                'attr' => ['class' => 'form-control', 'placeholder' => 'e.g., 2023'],
                'constraints' => [
                    new Range([
                        'min' => 1000,
                        'max' => date('Y') + 1,
                        'notInRangeMessage' => 'Publication year must be between {{ min }} and {{ max }}',
                    ]),
                ],
            ])
            ->add('description', TextareaType::class, [
                'label' => 'Annotation',
                'required' => false,
                'attr' => ['class' => 'form-control', 'rows' => 5, 'placeholder' => 'Book annotation.'],
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Book::class,
            'csrf_protection' => true,
            'csrf_field_name' => '_token',
            'csrf_token_id' => 'book_item',
        ]);
    }
}