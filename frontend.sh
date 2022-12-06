 echo Installing Nginx
 yum install nginx -y &>>/tmp/frontend

 echo Downloading the webcontent
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip" &>>/tmp/frontend


 cd /usr/share/nginx/html &>>/tmp/frontend

 echo Removing the old webcontent
 rm -rf * &>>/tmp/frontend
 unzip /tmp/frontend.zip &>>/tmp/frontend

 echo Moving the frontend-main
 mv frontend-main/static/* . &>>/tmp/frontend
 mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/frontend

 echo Restarting Nginx
 systemctl restart nginx &>>/tmp/frontend
 systemctl enable nginx &>>/tmp/frontend
  systemctl start nginx &>>/tmp/frontend