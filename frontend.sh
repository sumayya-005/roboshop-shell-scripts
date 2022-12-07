Log_File=/tmp/frontend


source=common.sh

 echo Installing Nginx
 yum install nginx -y &>>$Log_File
 StatusCheck $?

 echo Downloading the webcontent
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>$Log_File
StatusCheck $?

 cd /usr/share/nginx/html &>>$Log_File

 echo Removing the old webcontent
 rm -rf * &>>$Log_File
 unzip /tmp/frontend.zip &>>$Log_File
StatusCheck $?

 echo Moving the frontend-main
 mv frontend-main/static/* . &>>$Log_File
 mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>$Log_File
StatusCheck $?


 echo Restarting Nginx
 systemctl restart nginx &>>$Log_File
 systemctl enable nginx &>>$Log_File
StatusCheck $?