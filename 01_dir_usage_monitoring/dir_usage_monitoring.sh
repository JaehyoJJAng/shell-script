#!/usr/bin/env bash

if [[ ${#} -ne 1 ]]; then
  echo -e "Check The Argument\n${0} TARGET_DIR"
    exit 1
fi

# ------ TARGET DIRECTORY  ------
TARGET_DIR="${1}"

# ------ Monitoring Function ------
function monitoring() {
  echo "${TARGET_DIR} 디렉토리의 모니터링을 시작합니다"

  USAGES=($(du -k ${TARGET_DIR} | awk '{print $1}'))
  FILES=($(du -k ${TARGET_DIR} | awk '{print $2}'))

  for idx in "${!USAGES[@]}";
  do
    USAGE=${USAGES[${idx}]}
    FILE=${FILES[${idx}]}

    if [[ ${USAGE} -gt 25000 ]];then
      echo -e "${FILE}\t${USAGE}"
    fi
  done
}
monitoring 2>/dev/null