#!/bin/bash

# Check if either a directory or file exists

location=${HOME}
file_name='sentinel'

if [[ -e ${location} ]]; then
	echo "Ok on the ${location} directory"
	echo "Now Checking on the file, ${file_name}"

	if [[ -e "${location}/${file_name}" ]];then
		echo "Ok on the filename"
		echo "Updating Current Date .."
		date >> ${location}/${file_name}

	else
		echo "File does not exists"
	fi
else
	echo "The ${location} does not exists"
fi

