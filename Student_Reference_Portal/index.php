<?php
require 'auth.php';
requireLogin();
$canWrite  = in_array($_SESSION['role_id'], [ROLE_TUTOR, ROLE_ADMIN]);
$canDelete = $_SESSION['role_id'] === ROLE_ADMIN;
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Reference Portal</title>
</head>
<body>

  <h2>Student Reference Portal</h2>
  <p>
    Signed in as: <strong><?= htmlspecialchars($_SESSION['full_name']) ?></strong>
    (<?= htmlspecialchars($_SESSION['role_name']) ?>)
    &nbsp;|&nbsp; <a href="logout.php">Sign out</a>
  </p>

  <hr>

  <h3>Articles</h3>

  <p>
    <input type="text" id="searchInput" placeholder="Search by title">
    <select id="filterCategory"><option value="">All categories</option></select>
    <button onclick="loadArticles()">Search</button>
    <?php if ($canWrite): ?>
      <button onclick="openCreate()">Add article</button>
    <?php endif; ?>
  </p>

  <table border="1" cellpadding="6" cellspacing="0">
    <thead>
      <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Subject</th>
        <th>Category</th>
        <th>Author</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody id="articleTable">
      <tr><td colspan="7">Loading...</td></tr>
    </tbody>
  </table>

  <hr>

  <!-- View panel -->
  <div id="viewPanel" style="display:none">
    <h3 id="viewTitle"></h3>
    <p><strong>Subject:</strong> <span id="viewSubject"></span></p>
    <p><strong>Category:</strong> <span id="viewCategory"></span></p>
    <p><strong>Status:</strong> <span id="viewStatus"></span></p>
    <p><strong>Content:</strong></p>
    <p id="viewContent"></p>
    <button onclick="closeView()">Close</button>
    <hr>
  </div>

  <?php if ($canWrite): ?>
  <!-- Add / Edit form -->
  <div id="articleForm" style="display:none">
    <h3 id="formTitle">Article</h3>
    <input type="hidden" id="articleId">
    <p><label>Title<br><input type="text" id="fTitle" size="60"></label></p>
    <p><label>Content<br><textarea id="fContent" rows="6" cols="60"></textarea></label></p>
    <p>
      <label>Subject<br><select id="fSubject"></select></label>
      &nbsp;
      <label>Category<br><select id="fCategory"></select></label>
      &nbsp;
      <label>Status<br>
        <select id="fStatus">
          <option value="Published">Published</option>
          <option value="Draft">Draft</option>
        </select>
      </label>
    </p>
    <p>
      <button onclick="saveArticle()">Save</button>
      <button onclick="closeForm()">Cancel</button>
    </p>
    <p id="formMsg"></p>
  </div>
  <?php endif; ?>

<script>
const API       = 'api.php';
const canWrite  = <?= $canWrite  ? 'true' : 'false' ?>;
const canDelete = <?= $canDelete ? 'true' : 'false' ?>;

async function init() {
  const [subs, cats] = await Promise.all([
    fetch(API + '?action=get_subjects').then(r => r.json()),
    fetch(API + '?action=get_categories').then(r => r.json())
  ]);

  const fc = document.getElementById('filterCategory');
  cats.forEach(c => fc.appendChild(new Option(c.category_name, c.category_id)));

  if (canWrite) {
    const fs = document.getElementById('fSubject');
    subs.forEach(s => fs.appendChild(new Option(s.subject_name, s.subject_id)));
    const fcat = document.getElementById('fCategory');
    cats.forEach(c => fcat.appendChild(new Option(c.category_name, c.category_id)));
  }

  loadArticles();
}

async function loadArticles() {
  const kw  = document.getElementById('searchInput').value;
  const cat = document.getElementById('filterCategory').value;
  const rows = await fetch(
    `${API}?action=list_articles&keyword=${encodeURIComponent(kw)}&category_id=${cat}`
  ).then(r => r.json());

  const tbody = document.getElementById('articleTable');
  if (!rows.length) {
    tbody.innerHTML = '<tr><td colspan="7">No articles found.</td></tr>';
    return;
  }

  tbody.innerHTML = rows.map(r => `
    <tr>
      <td>${r.article_id}</td>
      <td>${r.title}</td>
      <td>${r.subject_name}</td>
      <td>${r.category_name}</td>
      <td>${r.author}</td>
      <td>${r.status}</td>
      <td>
        <button onclick="viewArticle(${r.article_id})">View</button>
        ${canWrite  ? `<button onclick="openEdit(${r.article_id})">Edit</button>` : ''}
        ${canDelete ? `<button onclick="deleteArticle(${r.article_id})">Delete</button>` : ''}
      </td>
    </tr>`).join('');
}

async function viewArticle(id) {
  const a = await fetch(`${API}?action=get_article&id=${id}`).then(r => r.json());
  document.getElementById('viewTitle').textContent    = a.title;
  document.getElementById('viewSubject').textContent  = a.subject_name;
  document.getElementById('viewCategory').textContent = a.category_name;
  document.getElementById('viewStatus').textContent   = a.status;
  document.getElementById('viewContent').textContent  = a.content;
  document.getElementById('viewPanel').style.display  = 'block';
  document.getElementById('viewPanel').scrollIntoView({ behavior: 'smooth' });
}

function closeView() {
  document.getElementById('viewPanel').style.display = 'none';
}

function openCreate() {
  closeView();
  document.getElementById('formTitle').textContent = 'Add article';
  document.getElementById('articleId').value = '';
  document.getElementById('fTitle').value    = '';
  document.getElementById('fContent').value  = '';
  document.getElementById('fStatus').value   = 'Published';
  document.getElementById('formMsg').textContent = '';
  document.getElementById('articleForm').style.display = 'block';
  document.getElementById('articleForm').scrollIntoView({ behavior: 'smooth' });
}

async function openEdit(id) {
  closeView();
  const a = await fetch(`${API}?action=get_article&id=${id}`).then(r => r.json());
  document.getElementById('formTitle').textContent   = 'Edit article';
  document.getElementById('articleId').value  = a.article_id;
  document.getElementById('fTitle').value     = a.title;
  document.getElementById('fContent').value   = a.content;
  document.getElementById('fSubject').value   = a.subject_id;
  document.getElementById('fCategory').value  = a.category_id;
  document.getElementById('fStatus').value    = a.status;
  document.getElementById('formMsg').textContent = '';
  document.getElementById('articleForm').style.display = 'block';
  document.getElementById('articleForm').scrollIntoView({ behavior: 'smooth' });
}

function closeForm() {
  document.getElementById('articleForm').style.display = 'none';
}

async function saveArticle() {
  const id   = document.getElementById('articleId').value;
  const body = new FormData();
  body.append('title',       document.getElementById('fTitle').value);
  body.append('content',     document.getElementById('fContent').value);
  body.append('subject_id',  document.getElementById('fSubject').value);
  body.append('category_id', document.getElementById('fCategory').value);
  body.append('status',      document.getElementById('fStatus').value);

  const action = id ? 'update_article' : 'create_article';
  if (id) body.append('article_id', id);

  const res = await fetch(`${API}?action=${action}`, { method: 'POST', body })
    .then(r => r.json());

  if (res.success) {
    closeForm();
    loadArticles();
  } else {
    document.getElementById('formMsg').textContent = res.error || 'Save failed.';
  }
}

async function deleteArticle(id) {
  if (!confirm('Delete article ' + id + '?')) return;
  const body = new FormData();
  body.append('id', id);
  const res = await fetch(`${API}?action=delete_article`, { method: 'POST', body })
    .then(r => r.json());
  if (res.success) loadArticles();
  else alert(res.error || 'Delete failed.');
}

init();
</script>

</body>
</html>