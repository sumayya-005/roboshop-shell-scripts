Log_File=/tmp/catalogue


echo "Setup Catalogue NodeJs"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$Log_File
if [ $? -eq 0 ];
  echo status=SUCESS
then
  echo status=FAILURE
 
fi

echo "Installing Nodejs "
yum install nodejs -y &>>$Log_File
if [ $? -eq 0 ];
  echo status=SUCESS
then
  echo status=FAILURE
fi

echo "Add Roboshop Username"
useradd roboshop &>>$Log_File
if [ $? -eq 0 ];
  echo status=SUCESS
then
  echo status=FAILURE
fi
echo "Download the schema"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$Log_File
if [ $? -eq 0 ];
  echo status=SUCESS
then
  echo status=FAILURE
fi

cd /home/roboshop

echo "Extract the Schema"
unzip /tmp/catalogue.zip &>>$Log_File
mv catalogue-main catalogue &>>$Log_File
cd /home/roboshop/catalogue &>>$Log_File
if [ $? -eq 0 ];
  echo status=SUCESS
then
  echo status=FAILURE
fi

echo "Install the NodeJs Dependencies"
npm install &>>$Log_File
if [ $? -eq 0 ];
  echo status=SUCESS
then
  echo status=FAILURE
fi

echo "Setup the Catalogue Service"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>$Log_File
if [ $? -eq 0 ];
  echo status=SUCESS
then
  echo status=FAILURE
fi

systemctl daemon-reload &>>$Log_File
systemctl enable catalogue &>>$Log_File

echo "Start the Service"
systemctl start catalogue &>>$Log_File
if [ $? -eq 0 ];
  echo status=SUCESS
then
  echo status=FAILURE
fi