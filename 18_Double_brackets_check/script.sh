#!/bin/bash

# using double parenthesis

val_1=10

if (( ${val_1} ** 2 > 90 ))
then
	(( val_2 = ${val_1} ** 2 ))
	echo "The square of ${val_1} is ${val_2}"
fi
