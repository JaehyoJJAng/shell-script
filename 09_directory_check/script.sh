#!/bin/bash
pwd=$(pwd)
dir="${pwd}/arthur"

if [[ -d ${dir} ]];then
	echo "The ${dir} exists"
else
	echo "The ${dir} does not exists"
fi
