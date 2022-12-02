#!/bin/bash

# 둘 이상의 SQL 명령 보내기

MYSQL=$(which mysql)
${MYSQL} -u test << EOF
use test;
show tables;
desc testTBL;
select * from test.testTBL;
EOF
