#!/bin/bash

command_1=($(ps -u user-01 --no-heading | gawk '{print $1}'))

for pid in "${command_1[@]}"
do
	echo ${pid} | gawk '{print $1}'
done

