#!/usr/bin/bash

BACKDIR=/home/ykose/yedekSBOX
DATE=`date +'%m-%d-%Y'`
WPDOSYA=`for file in $BACKDIR/*$DATE.sql.gz; do echo "${file}"; done`
BASE64=$( base64 $WPDOSYA -w 0)

#mods
TEMPLATE="
{
'phone': '999999999',
'filename': 'test.pdf',
'base64': 'data:file/pdf;base64', \"$BASE64\",
'isGroup': 'false'
}
"
echo $TEMPLATE > template.txt

curl -X 'POST' \
'http://127.0.0.1:5555/api/sinebox/send-file-base64' \
-H 'accept: /' \
-H 'Authorization: Bearer $2b$10$DQmaItvVtZUUpEDCwGLPCOazPAms02NytCa81uWTQgVqJcS4_5g4m' \
-H 'Content-Type: application/json' \
-d @template.txt
