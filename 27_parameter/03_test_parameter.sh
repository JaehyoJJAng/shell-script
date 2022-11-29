#!/bin/bash


# Testing parameters before use

# -n : null 값인지 확인
if [[ -n ${1} ]]
then
	echo "Hello ${1} glad to meet you"
else
	echo "Sorry, you dit not identify yourself"
fi
