#!/bin/bash

# Testing Array

declare -a arr1
declare -a arr2

arr1=('hello' 'bye' 'good' 'sir' 'yes')
arr2=('fuck' 'asshole' 'bitch' 'son of' 'chaonima')

for index in ${!arr1[@]}
do
	echo ${arr1[${index}]}
	echo ${arr2[${index}]}
done
