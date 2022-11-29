#!/bin/bash

# Testing a multicommand while loop

var_1=10

while echo ${var_1}
	[ ${var_1} -ge 0 ]
do
	echo "This is inside the loop"
	var_1=$[ ${var_1} -1 ]
done

