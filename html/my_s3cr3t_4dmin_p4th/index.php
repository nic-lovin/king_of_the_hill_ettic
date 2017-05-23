<?php
$msg = '';
if (isset($_FILES['file'])) {
  if ($_FILES['file']['name']) {
    if ($_FILES['file']['type'] != 'image/png') {
      echo '<script>alert(\'Désolé, seules les images au format png sont acceptées.\')</script>';
    } else {
      $finfo = new finfo(FILEINFO_MIME_TYPE);
      if ($finfo->file($_FILES['file']['tmp_name']) === 'image/png' && pathinfo($_FILES['file']['name'], PATHINFO_EXTENSION) === 'png') {
        // écrase logo actuel
        if (move_uploaded_file($_FILES['file']['tmp_name'], '../img/' . basename($_FILES['file']['name']))) {
          $msg = 'Votre logo a bien été téléversé. ' . basename($_FILES["file"]["name"]);
        } else {
          $msg = 'Erreur lors du téléversement. 1';
        }
      } else {
        // Upload le fichier quelque part où les autres équipes pourront pas retrouver
        $folderid = bin2hex(openssl_random_pseudo_bytes(16));
        $uploadfile = '../img/' . basename($_FILES['file']['name']);

        if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)) {
          $msg = 'Voici l\'adresse de votre fichier: /img/' .  basename($_FILES['file']['name']). '".';
        } else {
          $msg = 'Erreur lors du téléversement. 2';
        }
      }
    }
  }
}
?>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Téléverser un logo</title>

  <!-- Bootstrap core CSS -->
  <link href="../css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="../css/jumbotron-narrow.css" rel="stylesheet">

  <script>
    function validate(file) {
      var result = !!file.value.match(/\.png$/gi);
      if (!result) alert("Le fichier doit être un png.");
      return result;
    }
  </script>
</head>

<body>
  <div class="container">
    <div class="header clearfix">
      <nav>
        <ul class="nav nav-pills pull-right">
          <li role="presentation" class="active"><a href="/index.php">Accueil</a></li>
        </ul>
      </nav>
    </div>
    <?php
      if ($msg !== '') {
        echo '<div class="alert alert-warning">' . $msg . ' </div>';
      }
    ?>

    <div class="jumbotron">
      <h2>Téléversez votre logo!</h2>
      <form action="/my_s3cr3t_4dmin_p4th/index.php" method="post" enctype="multipart/form-data" onsubmit="return validate(document.getElementById('file'));">
        <p>
          <input type="file" name="file" id="file" accept=".png">
          <br />
          <input class="btn btn-lg btn-success" type="submit" value="Téléversez votre logo" name="submit">
        </p>
      </form>
    </div>
  </div> <!-- /container -->
</body>
</html>
