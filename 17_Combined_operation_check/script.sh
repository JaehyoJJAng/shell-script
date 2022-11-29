#!/bin/bash

# testing compund comparisons

if [[ -d ${HOME} ]] && [[ -w "${HOME}/sentinel" ]]
then
	echo "The file exists and you can write to it"
else
	echo "i cannot write to the file"
fi
