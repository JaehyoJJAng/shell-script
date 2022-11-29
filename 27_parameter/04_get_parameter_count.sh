#!/bin/bash

paramCount=${#}

if [[ ${paramCount} -ne 2 ]]
then
	echo -e "\nUsage: ${0} a b\n"
else
	total=$[ ${1} + ${2} ]
	echo -e "\nThe total ${total}\n"
fi
