<?php
require 'auth.php';
require 'db.php';

if (!empty($_SESSION['user_id'])) {
    header('Location: index.php'); exit;
}

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $stmt = $pdo->prepare(
        "SELECT u.*, r.role_name FROM users u
         JOIN roles r ON u.role_id = r.role_id
         WHERE u.email = ? AND u.status = 'Active'"
    );
    $stmt->execute([trim($_POST['email'])]);
    $user = $stmt->fetch();

    if (!$user || !password_verify($_POST['password'], $user['password_hash'])) {
        $error = 'Invalid email or password.';
    } else {
        $_SESSION['user_id']   = $user['user_id'];
        $_SESSION['full_name'] = $user['full_name'];
        $_SESSION['role_id']   = $user['role_id'];
        $_SESSION['role_name'] = $user['role_name'];
        header('Location: index.php'); exit;
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login</title>
</head>
<body>
  <h2>Student Reference Portal Login</h2>

  <?php if ($error): ?>
    <p><?= htmlspecialchars($error) ?></p>
  <?php endif; ?>

  <form method="POST">
    <p>
      <label>Email<br>
        <input type="email" name="email" required
               value="<?= htmlspecialchars($_POST['email'] ?? '') ?>">
      </label>
    </p>
    <p>
      <label>Password<br>
        <input type="password" name="password" required>
      </label>
    </p>
    <p><button type="submit">Sign in</button></p>
  </form>

  <hr>
  <p><small>
    Test logins (password is <strong>password</strong> for all):<br>
    student@example.com/ tutor@example.com/ admin@example.com
  </small></p>
</body>
</html>