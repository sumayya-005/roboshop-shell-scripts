Log_File=/tmp/mongo
echo "Setup Mongodb Repo"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>$Log_File
echo Status=$?


 echo "Installing Mongodb"
 yum install -y mongodb-org &>>$Log_File
echo Status=$?

 echo "Update the Listen Address"
 sed -i -e '/s/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$Log_File
echo status=$?

 echo "Starting Mongodb "
 systemctl enable mongod &>>$Log_File
 systemctl restart mongod &>>$Log_File
echo Status=$?

echo "Download the Mongodb Schema files"
 curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>$Log_File
echo Status=$?


 cd /tmp &>>$Log_File

 echo "Extract the files"
 unzip mongodb.zip &>>$Log_File
 cd mongodb-main &>>$Log_File
 echo Status=$?

 echo "Load the Catalogue schema"
 mongo < catalogue.js &>>$Log_File
 echo Status=$?

 echo "Load the User schema"
 mongo < users.js &>>$Log_File
 echo Status=$?

