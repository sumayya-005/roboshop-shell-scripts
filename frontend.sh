 echo Installing Nginx
 yum install nginx -y

 echo Downloading the webcontent
 curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"


 cd /usr/share/nginx/html

 echo Removing the old webcontent
 rm -rf *
 unzip /tmp/frontend.zip

 echo Moving the frontend-main
 mv frontend-main/static/* .
 mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf

 echo Restarting Nginx
 systemctl restart nginx
 systemctl enable nginx
  systemctl start nginx