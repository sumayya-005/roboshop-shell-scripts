ID=$(id -u)
if [ $ID -ne 0 ]; then
  echo you should run this script with a sudo privilages or root useradd
  exit
fi

StatusCheck() {
 if [ $1 -eq 0 ];then
   echo -e status="\e[32mSUCCESS\e[0m"
 else
   echo -e status="\e[35mFAILURE\e[0m"
 exit 1
 fi
}