#!/bin/bash

# testing file dates

FILE_1='./test1.sh'
FILE_2='./test2.sh'

if [[ ! -e ${FILE_1} ]] || [[ ! -e ${FILE_2} ]]
then
	echo "The File does not exists!"
	exit 1
fi

# -nt : 어떤 파일이 다른 파일보다 최신인지 여부 확인
# -ot : 어떤 파일이 다른 파일보다 오래되었는지 여부 확인

if [[ ${FILE_1} -nt ${FILE_2} ]]
then
	echo "The ${FILE_1} file is newer that ${FILE_2}"
else
	echo "The ${FILE_2} file is newer than ${FILE_1}"
fi

if [[ ${FILE_2} -ot ${FILE_1} ]]
then
	echo "The ${FILE_2} fie is older than the ${FILE_1}"
fi
