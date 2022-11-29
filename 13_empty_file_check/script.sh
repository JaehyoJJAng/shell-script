#!/bin/bash

# Testing if a file is empty

file_name="${HOME}/sentinel"

if [[ -f ${file_name} ]]
then
	if [[ -s ${file_name} ]]
	then
		echo "The ${file_name} file exists and has data in it."
		echo -e "\nReading a file ...\n"
		cat ${file_name}
	else
		echo "The ${file_name} file exists, but is empty"
		echo "Deleting empty file .."
		rm -rf ${file_name}
	fi
else
	echo "File, ${file_name} does not exists"
fi

