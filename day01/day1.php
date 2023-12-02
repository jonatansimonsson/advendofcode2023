<?php
$file = "advendofcode2023\day01\input.txt";

if(!file_exists($file)) {
    die("no such file");
}

$content = file_get_contents($file);

$puzzle = 2;
$line = preg_split("/\n/", $content);

$toBeReplaced = array("one", "two", "three", "four", "five", "six", "seven", "eight", "nine");
$replacement = array("o1e", "t2o", "3te", "f4r", "f5e", "s6x", "s7n", "e8t", "n9e");

$sum = 0;

foreach($line as $l) {

    $numbers = array();

    if ($puzzle == 2){
        $l = str_replace($toBeReplaced, $replacement, $l);
    }

    for($c = 0; $c < strlen($l); $c++) {
        if(is_numeric($l[$c])) {
            array_push($numbers, $l[$c]);
        }
    }

    if($numbers) {
        $sum += (int)(reset($numbers) . end($numbers));
    }    
}

print("Result of Part " . $puzzle . " is: " . $sum);


