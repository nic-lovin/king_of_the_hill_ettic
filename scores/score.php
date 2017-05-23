<?php

function inArray($id, $array) {
  foreach ($array as $key => $val) {
    if ($val['hash'] === $id) {
      return $key;
    }
  }
  return null;
}

$files = array_slice(scandir('img'), 2);
$stack = array();

foreach ($files as $file => $value) {
  $hash = md5_file('img/' . $value);
  if ($hash !== 'd1862b0393d5042bb9aa1b112bdd36db') {// Hash de l'image par défaut, on ne la veut pas dans le scoreboard
    $index = inArray($hash, $stack);
    if ($index === null) {
      array_push($stack, array('hash' => $hash, 'score' => 1, 'src' => $value));
    } else {
      $stack[$index]['score']++;
    }
  }
}

foreach ($stack as $key => $row) {
  $teams[$key]  = $row['hash'];
  $scores[$key] = $row['score'];
}

array_multisort($scores, SORT_DESC, $teams, SORT_ASC, $stack);

echo "<table style='width:90%'>";
echo "<tr>";
echo "<tr><th>Classement</th><th>Équipe</th><th>Pointage</th></tr>";

foreach ($stack as $key => $val) {
  echo "<tr>";
  echo "<th>" . ($key + 1) . "</th>";
  echo "<th><img src=img/" .$val['src'] . ' style="width:320px;height:240px;"/></th>';
  echo "<th>" . $val['score'] . "</th>";
  echo "</tr>";
}
echo "</table>";
header("Refresh:5");
?>


