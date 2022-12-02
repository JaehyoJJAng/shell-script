#!/bin/bash

MYSQL=$(which mysql)
QUERY='SELECT * FROM test.testTBL WHERE empid = 1'
${MYSQL} -u test -X -e "${QUERY}"
