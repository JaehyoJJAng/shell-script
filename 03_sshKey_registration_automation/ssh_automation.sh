SOURCE='/Users/jaehyolee/.ssh'
TARGET_HOST='user_01'
TARGET_IP='192.168.219.167'
PORT='9706'

/usr/bin/ssh-keygen -t rsa -N '' -f "${SOURCE}/id_rsa" <<< y 1>/dev/null

for x in $(ls -lh ${SOURCE} | awk '{print $9}');
do
  if [[ ${x} == 'id_rsa.pub' ]];then
  /usr/bin/scp -P ${PORT} "${SOURCE}/${x}" ${TARGET_HOST}@${TARGET_IP}:~/.ssh/test.pub
  fi
done
