<?php
$file = "advendofcode2023\day01\input.txt";

if(!file_exists($file)) {
    die("no such file");
}

$content = file_get_contents($file);

$puzzle = 2;
$line = preg_split("/\n/", $content);

$sum = 0;
foreach($line as $l) {
    $numbers = array();
    if ($puzzle == 2){
        $l = str_replace("one", "one1one", $l); $l = str_replace("two", "two2two",$l); $l = str_replace("three", "three3three",$l);
        $l = str_replace("four", "four4four",$l); $l = str_replace("five", "five5five",$l); $l = str_replace("six", "six6six",$l);
        $l = str_replace("seven", "seven7seven",$l); $l = str_replace("eight", "eight8eight",$l); $l = str_replace("nine", "nine9nine",$l);
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


