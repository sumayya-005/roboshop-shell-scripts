Log_File=/tmp/catalogue

ID=$(id -u)
if [ $ID -ne 0 ]; then
  echo you should run this script with a sudo privilages or root useradd
  exit
fi

echo "Setup Catalogue NodeJs"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$Log_File
if [ $? -eq 0 ];then
  echo status=SUCESS
else
  echo status=FAILURE
exit 1
fi

echo "Installing Nodejs "
yum install nodejs -y &>>$Log_File
if [ $? -eq 0 ];then
  echo status=SUCESS
else
  echo status=FAILURE
  exit 1
fi

echo "Add Roboshop Username"
useradd roboshop &>>$Log_File
if [ $? -eq 0 ];then
  echo status=SUCESS
else
  echo status=FAILURE
  exit 1
fi

echo "Download the schema"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$Log_File
if [ $? -eq 0 ];then
  echo status=SUCESS
else
  echo status=FAILURE
  exit 1
fi

cd /home/roboshop

echo "Extract the Schema"
unzip /tmp/catalogue.zip &>>$Log_File
mv catalogue-main catalogue &>>$Log_File
cd /home/roboshop/catalogue &>>$Log_File
if [ $? -eq 0 ];then
  echo status=SUCESS
else
  echo status=FAILURE
  exit 1
fi

echo "Install the NodeJs Dependencies"
npm install &>>$Log_File
if [ $? -eq 0 ];then
  echo status=SUCESS
else
  echo status=FAILURE
  exit 1
fi

echo "Setup the Catalogue Service"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>$Log_File
if [ $? -eq 0 ];then
  echo status=SUCESS
else
  echo status=FAILURE
  exit 1
fi

systemctl daemon-reload &>>$Log_File
systemctl enable catalogue &>>$Log_File

echo "Start the Service"
systemctl start catalogue &>>$Log_File
if [ $? -eq 0 ];then
  echo status=SUCESS
else
  echo status=FAILURE
  exit 1
fi