<?php
namespace App\Models;

use PDO;

class AddressModel
{
    private PDO $pdo;
    private int $maxPerPage = 500;

    public function __construct(PDO $pdo)
    {
        $this->pdo = $pdo;
    }

    /**
     * Получить список улиц с городом и регионом, с фильтрацией и пагинацией
     *
     * @param string|null $q
     * @param int $page 1-based
     * @param int $perPage
     * @return array [total => int, data => array]
     */
    public function list(?string $q, int $page = 1, int $perPage = 50): array
    {
        if ($perPage < 1) $perPage = 50;
        if ($perPage > $this->maxPerPage) $perPage = $this->maxPerPage;
        $offset = ($page - 1) * $perPage;

        $params = [];
        $where = 'TRUE';

        if ($q !== null && $q !== '') {
            $where = '(r.name ILIKE :q OR c.name ILIKE :q OR s.name ILIKE :q)';
            $params[':q'] = '%' . $q . '%';
        }

        $sqlCount = "SELECT COUNT(*) AS cnt
            FROM streets s
            JOIN cities c ON s.city_id = c.id
            JOIN regions r ON c.region_id = r.id
            WHERE {$where}";
        $stmt = $this->pdo->prepare($sqlCount);
        $stmt->execute($params);
        $total = (int)$stmt->fetchColumn();

        $sql = "SELECT
                r.id AS region_id, r.name AS region,
                c.id AS city_id, c.name AS city,
                s.id AS street_id, s.name AS street
            FROM streets s
            JOIN cities c ON s.city_id = c.id
            JOIN regions r ON c.region_id = r.id
            WHERE {$where}
            ORDER BY r.name, c.name, s.name
            LIMIT :limit OFFSET :offset";

        $stmt = $this->pdo->prepare($sql);
        foreach ($params as $k => $v) {
            $stmt->bindValue($k, $v, PDO::PARAM_STR);
        }
        $stmt->bindValue(':limit', (int)$perPage, PDO::PARAM_INT);
        $stmt->bindValue(':offset', (int)$offset, PDO::PARAM_INT);
        $stmt->execute();
        $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

        return [
            'total' => $total,
            'data' => $data,
            'page' => $page,
            'per_page' => $perPage,
        ];
    }
}
