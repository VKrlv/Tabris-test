<?php
namespace App\Controllers;

use App\Models\AddressModel;
use PDO;

class AddressController
{
    private PDO $pdo;
    private AddressModel $model;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
        $this->model = new AddressModel($pdo);
    }

    public function index(): void
    {
        header('Content-Type: application/json; charset=utf-8');

        $q = isset($_GET['q']) ? trim((string)$_GET['q']) : '';
        $page = isset($_GET['page']) ? max(1, (int)$_GET['page']) : 1;
        $perPage = isset($_GET['per_page']) ? (int)$_GET['per_page'] : 50;

        $result = $this->model->list($q === '' ? null : $q, $page, $perPage);

        echo json_encode($result, JSON_UNESCAPED_UNICODE);
    }
}
