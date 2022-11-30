#!/bin/bash

# trying to pass an array variable

function testit() {
	local newarray
	newarray=('echo "${@}"')
	echo "The parameters are: ${@}"
}

myarray=(1 2 3 4 5)
echo "The original array is: ${myarray[*]}"
testit ${myarray[*]}

