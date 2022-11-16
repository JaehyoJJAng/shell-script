#!/usr/bin/env bash

PER=${1}

if [[ ${PER} =~ [^0-9]  ]]; then
  echo -e "숫자만 입력하세요"
  exit 1
fi

if [[ ${#} -ne 1 ]];then
  echo -e "Usage\n==> ${0} [PERCENT ( 1 ~ 100)] <=="
  exit 1
fi


if [[ ${PER} -gt 100 ]] || [[ ${PER} -lt 0 ]];then
  echo -e "1 ~ 100의 범위에서만 입력하세요"
  exit 1
fi

DISK_USAGES=($(df -h | awk '{gsub(/%/,""); print $5}' | grep -v "[A-Z]"))
MNTS=($(df -h | awk '{print $9}' | grep -v "Mounted" | grep -v "[0-9]"))

for idx in "${!DISK_USAGES[@]}";
do
  DISK_USAGE=${DISK_USAGES[${idx}]}
  MNT=${MNTS[${idx}]}

  if [[ ${DISK_USAGE} -ge ${PER} ]];then
    echo -e "${DISK_USAGE}%\t${MNT}\n"
  fi
done

echo "Done"
