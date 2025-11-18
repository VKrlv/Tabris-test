<?php
declare(strict_types=1);

require __DIR__ . '/../app/bootstrap.php';

$uri = $_SERVER['REQUEST_URI'];
$method = $_SERVER['REQUEST_METHOD'];

$parsed = parse_url($uri);
$path = $parsed['path'];

if ($path === '/api/addresses' && $method === 'GET') {
    $controller = new \App\Controllers\AddressController($pdo);
    $controller->index();
    exit;
}

$indexFile = __DIR__ . '/assets/index.html';
if (file_exists($indexFile)) {
    echo file_get_contents($indexFile);
    exit;
}

echo "No frontend build found. API endpoint: /api/addresses?q=...&page=1&per_page=50";
