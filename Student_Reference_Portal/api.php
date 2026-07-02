<?php
header('Content-Type: application/json');
require 'auth.php';
requireLogin();
require 'db.php';

$action = $_REQUEST['action'] ?? '';
$role   = $_SESSION['role_id'];

function canWrite()  { return in_array($_SESSION['role_id'], [ROLE_TUTOR, ROLE_ADMIN]); }
function canDelete() { return $_SESSION['role_id'] === ROLE_ADMIN; }
function deny()      { echo json_encode(['error' => 'Access denied']); exit; }

switch ($action) {

    case 'list_articles':
        $kw  = '%' . ($_GET['keyword'] ?? '') . '%';
        $cat = $_GET['category_id'] ?? '';
        $sql = "SELECT a.article_id, a.title, a.status,
                       s.subject_name, c.category_name, u.full_name AS author
                FROM articles a
                JOIN subjects   s ON a.subject_id  = s.subject_id
                JOIN categories c ON a.category_id = c.category_id
                JOIN users      u ON a.created_by  = u.user_id
                WHERE a.title LIKE ?";
        $params = [$kw];
        if ($cat !== '') { $sql .= " AND a.category_id = ?"; $params[] = $cat; }
        $sql .= " ORDER BY a.created_at DESC";
        $stmt = $pdo->prepare($sql);
        $stmt->execute($params);
        echo json_encode($stmt->fetchAll());
        break;

    case 'get_article':
        $stmt = $pdo->prepare(
            "SELECT a.*, s.subject_name, c.category_name
             FROM articles a
             JOIN subjects   s ON a.subject_id  = s.subject_id
             JOIN categories c ON a.category_id = c.category_id
             WHERE a.article_id = ?"
        );
        $stmt->execute([$_GET['id']]);
        echo json_encode($stmt->fetch());
        break;

    case 'create_article':
        if (!canWrite()) { deny(); }
        $stmt = $pdo->prepare(
            "INSERT INTO articles (title, content, subject_id, category_id, created_by, status)
             VALUES (?, ?, ?, ?, ?, ?)"
        );
        $stmt->execute([
            $_POST['title'], $_POST['content'],
            $_POST['subject_id'], $_POST['category_id'],
            $_SESSION['user_id'], $_POST['status']
        ]);
        echo json_encode(['success' => true, 'id' => $pdo->lastInsertId()]);
        break;

    case 'update_article':
        if (!canWrite()) { deny(); }
        $stmt = $pdo->prepare(
            "UPDATE articles SET title=?, content=?, subject_id=?, category_id=?, status=?
             WHERE article_id=?"
        );
        $stmt->execute([
            $_POST['title'], $_POST['content'],
            $_POST['subject_id'], $_POST['category_id'],
            $_POST['status'], $_POST['article_id']
        ]);
        echo json_encode(['success' => true]);
        break;

    case 'delete_article':
        if (!canDelete()) { deny(); }
        $stmt = $pdo->prepare("DELETE FROM articles WHERE article_id = ?");
        $stmt->execute([$_POST['id']]);
        echo json_encode(['success' => true]);
        break;

    case 'get_subjects':
        echo json_encode($pdo->query("SELECT * FROM subjects")->fetchAll());
        break;

    case 'get_categories':
        echo json_encode($pdo->query("SELECT * FROM categories")->fetchAll());
        break;

    default:
        echo json_encode(['error' => 'Unknown action']);
}
?>