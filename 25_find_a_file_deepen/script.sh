#!/bin/bash

# finding files in the PATH

IFSOLD=${IFS}
IFS=:
for folder in ${PATH}
do
	echo ${folder}
done
