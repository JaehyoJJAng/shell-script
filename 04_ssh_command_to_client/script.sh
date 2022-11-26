#!/bin/bash

# 배열 정의
declare -a server_list_len
declare -a server_list

# FILE
FILE='/home/wogy12395/git/shell-script/04_ssh_command_to_client/server_list.txt'

server_list_len=$(cat  ${FILE} | wc -l)
server_list=($(cat ${FILE}))

# 0번째 인자 ~ 9번째 인자 (10개)
for idx in $(eval seq 0 $[ ${server_list_len} -1]);
do

	echo "${server_list[${idx}]}"
	ssh user@"${server_list[${idx}]}" -p 9706 "ls -alht ~/"
done

