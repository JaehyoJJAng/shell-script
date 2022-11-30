#!/bin/bash

# count number of files in your PATH

mypath=$(echo ${PATH} | sed 's/:/ /g')
count=1
for directory in ${mypath}
do
	check=$(ls -lh ${directory} | gawk '{print $9}')
	for item in ${check}
	do
		count=$[ ${count} + 1 ]
	done

	echo "${directory} - ${count}"
done

