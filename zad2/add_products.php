<?php
// insert_products.php
require __DIR__.'/vendor/autoload.php';

use App\Entity\Product;
use Symfony\Component\Dotenv\Dotenv;

// Load environment variables
(new Dotenv())->bootEnv(__DIR__.'/.env');

// Initialize Symfony kernel
$kernel = new \App\Kernel($_SERVER['APP_ENV'], (bool) $_SERVER['APP_DEBUG']);
$kernel->boot();

// Get EntityManager
$entityManager = $kernel->getContainer()->get('doctrine')->getManager();

// Sample products to insert
$products = [
    'Laptop',
    'Smartphone',
    'Tablet',
    'Monitor',
    'Keyboard'
];

// Insert products
foreach ($products as $productName) {
    $product = new Product($productName);
    $entityManager->persist($product);
    echo "Adding product: $productName\n";
}

$entityManager->flush();
echo "Successfully added ".count($products)." products!\n";