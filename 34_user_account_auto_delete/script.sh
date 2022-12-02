#!/bin/bash

function get_answer {

# answer 변수 초기화
unset answer

ask_count=0
# -z : str의 길이가 0인 경우
while [ -z "$answer" ]    # answer에 값이 들어올 때 까지 loop 반복
do
     ask_count=$[ $ask_count + 1 ]
#
     case $ask_count in   # 유저가 제한 시간내에 아무 값을 answer에 넘기지 않은 경우
     2)
          echo
          echo "Please answer the question."
          echo
     ;;
     3)
          echo
          echo "One last try...please answer the question."
          echo
     ;;
     4)
          echo
          echo "Since you refuse to answer the question..."
          echo "exiting program."
          echo
          #
          exit 1
     ;;
     esac

# -n : str의 길이가 0보다 큰 경우
     if [ -n "$line2" ]
     then               #Print 2 lines
          echo $line1
          echo -e $line2" \c" # 줄바꿈 제거
     else                    #Print 1 line
          echo -e $line1" \c" # 줄바꿈 제거
     fi
#
#     Allow 60 seconds to answer before time-out
     read -t 60 answer
done

# line1 , line2 변수 초기화
unset line1
unset line2
#
}  #End of get_answer function

function process_answer() {
  answer=$(echo ${answer} | cut -c1)

  case ${answer} in
  y|Y)
  # If user answers "yes", do nothing.
  ;;
  *)
  # 유저가 n | N 를 누른 경우
  echo
  echo ${exit_line1}
  echo ${exit_line2}
  echo
  exit
  ;;
  esac
}

# line1 line2 변수에 텍스트 값 대입
line1="Please enter the username of the user "
line2="account you wish to delete from system:"
get_answer

# 유저 계정명 지정
user_account=$answer

# 다시 한번 더 물어보기
line1="Is $user_account the user account "
line2="you wish to delete from the system? [y/n]"
get_answer

# Call process_answer funtion:
#     if user answers anything but "yes", exit script
exit_line1="Because the account, $user_account, is not "
exit_line1="the one you wish to delete, we are leaving the script..."
process_answer
#
########################################################################
# 입력받은 유저 정보 찾기
# grep -w : 주어진 단어와 완벽하게 일치하는 부분만
user_account_record=$(cat /etc/passwd | grep -w "${user_account}")

# 입력 받은 계정이 시스템에 없는 경우
if [[ ${?} -eq 1 ]]
then
  echo ""
  echo "Account, ${user_account} not found"
  echo "Leaving the Script .."
  exit 1
fi

# 입력 받은 계정이 시스템에 있는 경우
echo -e "\nI found this Record:"

# user 명 : 경로 출력
User=$(echo ${user_account_record} | gawk -F':' '{print $1}')
Path=$(echo ${user_account_record} | gawk -F':' '{print $6}')
echo "${User}:${Path}"

# 해당 계정이 맞는지 다시 확인
line1="Is this the correct User Account? [y/n]"
get_answer

exit_line1="Because the account, $user_account, is not "
exit_line2="the one you wish to delete, we are leaving the script..."
process_answer

# 사용자 계정의 프로세스를 찾기
echo
echo "Step #2 - Find process on system belonging to user account"
echo

# ps -u <유저명> : 해당 유저가 사용중인 프로세스 확인
ps -u ${user_account} 1> /dev/null

# 해당 유저 시스템에서 실행 중인 프로세스가 있는 경우 상태코드 0 반환
# 해당 유저 시스템에서 실행 중인 프로세스가 없는 경우 상태코드 1 반환
case ${?} in
1)
  # no Process running for this user account
  echo "There are no precesses for this account"
  echo
;;
0)
  # Processes running for this user account
  # Ask script user if wants us to kill the processes

  # 실행 중인 프로세스 출력
  echo "${user_account} has the following process(es) running:"
  ps -u ${user_account}

  # 프로세스 죽일건지 스크립트 사용자에게 물어보기
  line1='Would you like me to kill the process(es)? [y/n]'
  get_answer

  # answer에 입력 된 값 중 제일 첫 번째 워딩 가져오기
  answer=$(echo ${answer} | cut -c1)
  case ${answer} in
  y|Y) # If user answers "yes".
       # Kill user Account processes
       echo
       echo "Killing off process(es) .."

       # List user process running code in command_1
       # 헤더 값 빼고 출력(맨 첫 컬럼)
       command_1=$(ps -u ${user_account} --no-heading)

       # Create command_3 to kill processes in variable
       command_3="xargs -d \\n /usr/bin/sudo /bin/kill -KILL"

       # Kill Process
       ${command_1} | gawk '{print $1}' | ${command_3}

       echo
       echo "Process(es) Killed"
  ;;

  *)
    # If user answers "no" or anything
    echo
    echo "Will not kill process(es)."
  ;;
  esac
;;
esac


#################################################################
# Create a report of all files owned by User Account
#
echo
echo "Step #3 - Find files on system belonging to user account"
echo
echo "Creating a report of all files owned by $user_account."
echo
echo "It is recommended that you backup/archive these files,"
echo "and then do one of two things:"
echo "  1) Delete the files"
echo "  2) Change the files' ownership to a current user account."
echo
echo "Please wait. This may take a while..."

# 유저파일 백업하기
report_date=$(date +'%Y%m%d')
report_file="${user_account}_Files_${report_date}.rpt"

# 유저파일 찾은 후 , 파일로 저장
find / -user ${user_account} 2>/dev/null > ${report_file}

echo
echo "Report is complete."
echo "Name of report:      $report_file"
echo -n "Location of report: "; pwd
echo

#  Remove User Account
echo
echo "Step #4 - Remove user account"
echo
#
line1="Do you wish to remove $user_account's account from system? [y/n]"
get_answer

# Call process_answer function:
#       if user answers anything but "yes", exit script
#
exit_line1="Since you do not wish to remove the user account,"
exit_line2="$user_account at this time, exiting the script..."
process_answer

# delete user account
userdel $user_account
echo
echo "User account, $user_account, has been removed"
echo
#
exit
