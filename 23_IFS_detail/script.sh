#!/bin/bash

# Changing the IFS value

IFS.OLD=${IFS}
IFS=$'\n'

for entry in $(cat /etc/passwd)
do
	echo "Values in ${entry} -"
	IFS=:
	for value in ${entry}
	do
		echo -e "\t${value}"
	done
	
	echo 
done
