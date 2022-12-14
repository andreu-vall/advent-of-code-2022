<?php
  $cave = [];
  $width = 1000;
  for ($i = 0; $i <= 600; $i++) {
    $cave[$i] = [];
    for ($j = 0; $j <= $width; $j++) {
      $cave[$i][$j] = ".";
    }
  }
  //Ampersand means pass by reference
  function swap(&$arr, $i, $j) {
    $tmp = $arr[$i];
    $arr[$i] = $arr[$j];
    $arr[$j] = $tmp;
  }
  
  $line = readline();
  $lowest = 0;
  while ($line != "") {
    $prev = NULL;
    foreach (explode(" -> ", $line) as &$path) {
      $path = array_map("intval", explode(",", $path));
      swap($path, 0, 1);
      if ($prev != NULL) {
        if ($prev[0] == $path[0]) {
          for ($j = min($prev[1], $path[1]); $j <= max($prev[1], $path[1]); $j++) {
            $cave[$prev[0]][$j] = "#";
            if ($prev[0] > $lowest) {
              $lowest = $prev[0];
            }
          }
        }
        else {
          assert ($prev[1] == $path[1]);
          for ($i = min($prev[0], $path[0]); $i <= max($prev[0], $path[0]); $i++) {
            $cave[$i][$prev[1]] = "#";
            if ($i > $lowest) {
              $lowest = $i;
            }
          }
        }
      }
      $prev = $path;
    }
    $line = readline();
  }
  for ($j = 0; $j <= 1500; $j++) {
    $cave[$lowest+2][$j] = "#";
  }
	$sand_unit = 0;
	$part1_solved = false;
	while (true) {
	  $i = 0;
	  $j = 500;
	  if ($cave[$i][$j] == "O") {
	    echo "Part 2: ", $sand_unit, "\n";
	    break;
	  }
	  while (true) {
	    if ($j == 0 || $j == $width-1) {
	      echo "RIP\n";
	    }
	    if ($i == $lowest+1 && !$part1_solved) {
	      echo "Part 1: ", $sand_unit, "\n";
	      $part1_solved = true;
	    }
	    if ($cave[$i+1][$j] == ".") {
	      $i++;
	    }
	    elseif ($cave[$i+1][$j-1] == ".") {
	      $i++;
	      $j--;
	    }
	    elseif ($cave[$i+1][$j+1] == ".") {
	      $i++;
	      $j++;
	    }
	    else {
	      $sand_unit++;
	      $cave[$i][$j] = "O";
	      break;
	    }
	  }
	}
?>
