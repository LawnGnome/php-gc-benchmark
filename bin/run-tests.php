<?php

const PHPS = [
  'master'        => '/opt/php/master/bin/php',
  'gc-timing'     => '/opt/php/gc-timing/bin/php',
  'gc-fn-pointer' => '/opt/php/gc-fn-pointer/bin/php',
];

const RUNS = 100;

printf('%-39s ', '');
foreach (PHPS as $label => $binary) {
  printf('%15s ', $label);
}
echo "\n";

foreach (glob('/source/tests/*php') as $test) {
  printf('%-39s ', basename($test));
  foreach (PHPS as $label => $binary) {
    $times = [];
    foreach (range(0, RUNS) as $i) {
      $start = microtime(true);
      shell_exec("$binary -n -d memory_limit=1G $test");
      $end = microtime(true);
      $times[] = $end - $start;
    }
    printf('%12.3f ', array_sum($times) / count($times));
  }
  echo "\n";
}
