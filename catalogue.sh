Log_File=/tmp/catalogue

echo "Install NodeJs"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$Log_File

echo "Install N"
yum install nodejs -y

  useradd roboshop
$ curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
$ cd /home/roboshop
$ unzip /tmp/catalogue.zip
$ mv catalogue-main catalogue
$ cd /home/roboshop/catalogue
$ npm install


# mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# systemctl daemon-reload
# systemctl start catalogue
# systemctl enable catalogue