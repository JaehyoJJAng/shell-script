#!/bin/bash

# 서버에 명령 보내기
MYSQL=$(which mysql)

${MYSQL} -u test -e 'DESC test.testTBL'
