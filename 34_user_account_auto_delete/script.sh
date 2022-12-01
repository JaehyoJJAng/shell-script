#!/bin/bash

function get_answer {
#
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
          exit
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
  # If user answers anything but "yes", exit script
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
#

