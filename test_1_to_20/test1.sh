#!/bin/bash
a=0
b=0
while [ $b -lt 100 ]
do
let b++
let a+=b
done
echo $a
