# curl-char-limit-post-fix
Solving a freelancer posted problem with error - curl file name too long

I have tested the issue and reproduced it on linux - Rocky Linux release 8.6 (Green Obsidian) - a clone of RHEL/CENTOS


I have tested a solution using a template for the payload instead of posting it as a command line argument ( The base64 encoded content is too long )


```
diff -y

#!/usr/bin/bash							#!/usr/bin/bash

BACKDIR=/home/ykose/yedekSBOX					BACKDIR=/home/ykose/yedekSBOX
DATE=`date +'%m-%d-%Y'`						DATE=`date +'%m-%d-%Y'`
WPDOSYA=`for file in $BACKDIR/*$DATE.sql.gz; do echo "${file}	WPDOSYA=`for file in $BACKDIR/*$DATE.sql.gz; do echo "${file}
BASE64=$( base64 $WPDOSYA -w 0)					BASE64=$( base64 $WPDOSYA -w 0)

#mods							      <
TEMPLATE="						      <
{							      <
'phone': '999999999',					      <
'filename': 'test.pdf',					      <
'base64': 'data:file/pdf;base64', \"$BASE64\",		      <
'isGroup': 'false'					      <
}							      <
"							      <
echo $TEMPLATE > template.txt				      <
							      <
curl -X 'POST' \						curl -X 'POST' \
'http://127.0.0.1:5555/api/sinebox/send-file-base64' \		'http://127.0.0.1:5555/api/sinebox/send-file-base64' \
-H 'accept: /' \						-H 'accept: /' \
-H 'Authorization: Bearer $2b$10$DQmaItvVtZUUpEDCwGLPCOazPAms	-H 'Authorization: Bearer $2b$10$DQmaItvVtZUUpEDCwGLPCOazPAms
-H 'Content-Type: application/json' \				-H 'Content-Type: application/json' \
-d @template.txt					      |	-d @< '{
							      >	"phone": "999999999",
							      >	"filename": 'test.pdf',
							      >	"base64": "data:file/pdf;base64", '$BASE64',
							      >	"isGroup": "false"
							      >	}'
```



https://www.freelancer.com/projects/shell-script/Bash-Script-CURL-POST-Error/details
