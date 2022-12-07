Log_File=/tmp/mongo

source common.sh


echo "Setup Mongodb Repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>$Log_File
StatusCheck $?

 echo "Installing Mongodb"
 yum install -y mongodb-org &>>$Log_File
StatusCheck $?

 echo "Update the Listen Address"
 sed -i -e '/s/127.0.0.1/0.0.0.0/' /etc/mongod.conf
StatusCheck $?


 echo "Starting Mongodb"
 systemctl enable mongod &>>$Log_File
 systemctl restart mongod &>>$Log_File
StatusCheck $?

echo "Download the Mongodb Schema files"
 curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>$Log_File
StatusCheck $?


 cd /tmp &>>$Log_File

 echo "Extract the files"
 unzip -o mongodb.zip &>>$Log_File

 StatusCheck $?

 cd mongodb-main

 echo "Load the Catalogue schema"
 mongo < catalogue.js &>>$Log_File
StatusCheck $?

 echo "Load the User schema"
 mongo < users.js &>>$Log_File
StatusCheck $?

