#!/bin/bash

# demonstrating the shift command

count=1

# ${1} 파라메터 값이 null이 아닐 때 까지 loop
# shift : 각 매개변수를 하나씩 왼쪽으로 옮김

while [[ -n "${1}" ]]
do
	echo "Parameter #${count} = ${1}"
	count=$[ ${count} + 1 ]
	shift
done
