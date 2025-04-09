<?php

namespace App\Controller;

use App\Entity\Product;
use App\Repository\ProductRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/product')]
class ProductController extends AbstractController
{
    #[Route('/', name: 'product_list', methods: ['GET'])]
    public function list(ProductRepository $productRepository): Response
    {
        $products = $productRepository->findAll();

        $data = array_map(fn($product) => [
            'id' => $product->getId(),
            'name' => $product->getName(),
        ], $products);

        return $this->json($data);
    }

    #[Route('/', name: 'product_create', methods: ['POST'])]
public function create(Request $request, ProductRepository $productRepository): Response
{
    $data = json_decode($request->getContent(), true);

    if (!isset($data['name'])) {
        return $this->json(['error' => 'Name is required'], Response::HTTP_BAD_REQUEST);
    }

    $product = new Product($data['name']);
    $productRepository->save($product);

    return $this->json([
        'id' => $product->getId(),
        'name' => $product->getName(),
    ], Response::HTTP_CREATED);
}

    #[Route('/{id}', name: 'product_show', methods: ['GET'])]
    public function show(int $id, ProductRepository $productRepository): Response
    {
        $product = $productRepository->find($id);

        if (!$product) {
            return $this->json(['error' => 'Not found'], 404);
        }

        return $this->json([
            'id' => $product->getId(),
            'name' => $product->getName(),
        ]);
    }

    #[Route('/{id}', name: 'product_update', methods: ['PUT', 'PATCH'])]
    public function update(int $id, Request $request, ProductRepository $productRepository): Response
    {
        $product = $productRepository->find($id);

        if (!$product) {
            return $this->json(['error' => 'Not found'], 404);
        }

        $data = json_decode($request->getContent(), true);

        if (isset($data['name'])) {
            $product->setName($data['name']);
        }

        $productRepository->update($product);

        return $this->json(['message' => 'Updated']);
    }

    #[Route('/{id}', name: 'product_delete', methods: ['DELETE'])]
    public function delete(int $id, ProductRepository $productRepository): Response
    {
        $product = $productRepository->find($id);

        if (!$product) {
            return $this->json(['error' => 'Not found'], 404);
        }

        $productRepository->remove($product);

        return $this->json(['message' => 'Deleted']);
    }
}
