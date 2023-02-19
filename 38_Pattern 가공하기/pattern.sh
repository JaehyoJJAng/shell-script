#!/usr/bin/bash

# 예제 내용
echo "Pattern WF1
AAA BBB CCC
DDD EEE FFF

Pattern WF2
FFF GGG CCC

Pattern WF3
SSS GGG CCC
HHH III JJJ
XXX VVV YYY" > pattern.txt

# group_nm 초기값
group_nm=""

# pattern.txt Loop #1
while read line
do
    # 공백 값은  continue 처리
    if [[ ${line} == "" ]]
    then
        continue
    fi

    # WF{1..3} 부분 가져오기
    ret=$(echo ${line} | grep "Pattern" | awk '{print $2}')

    if [[ "${ret}" != "" ]] && [[ "${group_nm}" != "${ret}" ]]
    then
        group_nm=${ret}
        continue
    fi

    echo "${group_nm} ${line}"
done < pattern.txt


# pattern.txt Loop #2
group_nm=""

while read line
do
    if [[ ${line} == Pattern* ]]
    then
        pattern=$(echo "${line}" | awk '{print $2}')
    elif [[ ! -z ${line} ]]
    then
        echo "${pattern} $(echo ${line} | tr -s '' )"
    fi
done < pattern.txt