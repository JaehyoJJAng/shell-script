#!/bin/bash

# URL
URL='www.quotationspage.com/qohd.html'

# Wget Log FIle
LOGFILE='wget.log'

# 웹주소 검사하기
# -nv(non-verbose) : 붚 필요하게 출력 되는 데이터 줄이기
# --spider : 주소 유효성 체크
/usr/bin/wget -nv --spider ${URL} 1>/dev/null

##### Get Qotd.html
# -o : Log 파일에 세션 출력 저장
/usr/bin/wget -o ${LOGFILE} ${URL} && echo "Done" || exit 1

# -O : 웹 페이지 정보가 저장되는 위치를 제어
/usr/bin/wget -o ${LOGFILE} -O Daily_Quote.html ${URL}
