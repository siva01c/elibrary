<?php

namespace App\Controller;

use App\Entity\Book;
use App\Form\BookType;
use App\Repository\BookRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

final class BookController extends AbstractController
{
    #[Route('/', name: 'app_book_index')]
    public function index(BookRepository $bookRepository): Response
    {
        $books = $bookRepository->findAll();
        
        return $this->render('book/index.html.twig', [
            'books' => $books,
        ]);
    }

    #[Route('/book/{id}', name: 'app_book_preview', requirements: ['id' => '\d+'])]
    public function preview(Book $book): Response
    {
        return $this->render('book/preview.html.twig', [
            'book' => $book,
        ]);
    }

    #[Route('/book/new', name: 'app_book_new')]
    #[IsGranted('ROLE_ADMIN')]
    public function new(Request $request, EntityManagerInterface $entityManager): Response
    {
        $book = new Book();
        $form = $this->createForm(BookType::class, $book);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($book);
            $entityManager->flush();

            $this->addFlash('success', 'Book created successfully!');
            return $this->redirectToRoute('app_book_preview', ['id' => $book->getId()]);
        }

        return $this->render('book/add.html.twig', [
            'book' => $book,
            'form' => $form,
        ]);
    }

    #[Route('/book/{id}/edit', name: 'app_book_edit', requirements: ['id' => '\d+'])]
    #[IsGranted('ROLE_ADMIN')]
    public function edit(Request $request, Book $book, EntityManagerInterface $entityManager): Response
    {
        $form = $this->createForm(BookType::class, $book);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->flush();

            $this->addFlash('success', 'Book updated successfully!');
            return $this->redirectToRoute('app_book_preview', ['id' => $book->getId()]);
        }

        return $this->render('book/edit.html.twig', [
            'book' => $book,
            'form' => $form,
        ]);
    }

    #[Route('/book/{id}/delete', name: 'app_book_delete', requirements: ['id' => '\d+'], methods: ['POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function delete(Request $request, Book $book, EntityManagerInterface $entityManager): Response
    {
        if ($this->isCsrfTokenValid('delete'.$book->getId(), $request->request->get('_token'))) {
            $entityManager->remove($book);
            $entityManager->flush();
            $this->addFlash('success', 'Book deleted successfully!');
        }

        return $this->redirectToRoute('app_book_index');
    }


    #[Route('/book/{id}/print', name: 'app_book_print', requirements: ['id' => '\d+'])]
    public function print(Book $book): Response
    {
        return $this->render('book/print.html.twig', [
            'book' => $book,
        ]);
    }

    #[Route('/books/export', name: 'app_books_export')]
    #[IsGranted('ROLE_ADMIN')]
    public function export(BookRepository $bookRepository): Response
    {
        $books = $bookRepository->findAll();
        $booksData = [];

        foreach ($books as $book) {
            $booksData[] = [
                'title' => $book->getTitle(),
                'author' => $book->getAuthor(),
                'isbn' => $book->getIsbn(),
                'description' => $book->getDescription(),
                'publicationYear' => $book->getPublicationYear(),
            ];
        }

        $jsonData = json_encode($booksData, JSON_PRETTY_PRINT);

        $response = new Response($jsonData);
        $response->headers->set('Content-Type', 'application/json');
        $response->headers->set('Content-Disposition', 'attachment; filename="books.json"');

        return $response;
    }

    #[Route('/books/import', name: 'app_books_import', methods: ['POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function import(EntityManagerInterface $entityManager): Response
    {
        $filePath = dirname($this->getParameter('kernel.project_dir')) . '/datasource/books.json';

        if (!file_exists($filePath)) {
            $this->addFlash('error', 'books.json file not found in datasource folder.');
            return $this->redirectToRoute('app_book_index');
        }

        try {
            $fileContent = file_get_contents($filePath);
            $booksData = json_decode($fileContent, true);

            if (json_last_error() !== JSON_ERROR_NONE) {
                $this->addFlash('error', 'Invalid JSON file format.');
                return $this->redirectToRoute('app_book_index');
            }

            $importedCount = 0;
            foreach ($booksData as $bookData) {
                if (isset($bookData['title']) && isset($bookData['author'])) {
                    $book = new Book();
                    $book->setTitle($bookData['title']);
                    $book->setAuthor($bookData['author']);
                    
                    if (isset($bookData['isbn'])) {
                        $book->setIsbn($bookData['isbn']);
                    }
                    if (isset($bookData['description'])) {
                        $book->setDescription($bookData['description']);
                    }
                    if (isset($bookData['publicationYear'])) {
                        $book->setPublicationYear($bookData['publicationYear']);
                    }

                    $entityManager->persist($book);
                    $importedCount++;
                }
            }

            $entityManager->flush();
            $this->addFlash('success', "Successfully imported {$importedCount} books from books.json.");

        } catch (\Exception $e) {
            $this->addFlash('error', 'Error processing the import: ' . $e->getMessage());
        }

        return $this->redirectToRoute('app_book_index');
    }
}
