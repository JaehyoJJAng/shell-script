#!/bin/bash

### Python
python=$(which python3)
#

### Input URL 
quote_url='http://www.quotationspage.com/qotd.html'
#

### 웹 페이지 유효성 체크
# 1. 출력을 저장하려면 명령 주위에 표준 $() 구문 사용
# 2. 추가로 STDERR 및 STDOUT 리다이렉트도 필요 (2>&1)
check_url=$(/usr/bin/wget -nv --spider ${quote_url} 2>&1 | awk '{print $5}' ) || exit 1
#

### response status가 200이 아닌 경우 프로그램 종료 
if [[ ${check_url} != 200 ]]
then
	echo -e "RESPONSE ERROR! : ${check_url}"
	exit 1
fi
#

### /tmp/에 quote용 디렉토리 생성
if [[ ! -e /tmp/quote ]]
then
	echo "Creating Quote Directory"
	/usr/bin/mkdir /tmp/quote
	echo -e "\nDone!"
fi
#

### 웹 페이지 정보 가져오기
wget -o /tmp/quote/quote.log -O /tmp/quote/quote.html ${quote_url}

### 파이썬으로 해당 웹 데이터 파싱하기
${python} parsing.py
#

### 3일 이상 지난 명언 파일 삭제하기
find /tmp/daily_quote/ -iname "*.txt" -mtime +3 | xargs -I % sh -c '{echo Removing %;rm -f %}'
#
