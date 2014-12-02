<?php

class C {
}

// Build pairs of objects that refer to each other.
$objs = [];
foreach (range(0, 100000) as $_) {
  $objA = new C;
  $objB = new C;

  $objA->b = $objB;
  $objB->a = $objA;

  $objs[] = $objA;
  $objs[] = $objB;
}

// Remove 10% of them, causing 60 GC runs.
$i = 0;
$objs = array_filter($objs, function ($obj) use (&$i) {
  return (++$i % 10) == 0;
});
