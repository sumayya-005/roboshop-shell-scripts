Log_File=/tmp/catalogue

source common.sh

echo "Setup Catalogue NodeJs"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$Log_File
StatusCheck $?

echo "Installing Nodejs "
yum install nodejs -y &>>$Log_File
StatusCheck $?

id roboshop &>>$Log_File
if [ $? -ne 0 ]; then
  echo "Add Roboshop Username"
  useradd roboshop &>>$Log_File
StatusCheck $?
fi




echo "Download the  Catalogue schema"
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>$Log_File
StatusCheck $?

cd /home/roboshop


echo "Removing the old content"
rm -rf catalogue &>>$Log_File
StatusCheck $?


echo "Extract the Catalogue"
unzip /tmp/catalogue.zip &>>$Log_File
StatusCheck $?

mv catalogue-main catalogue &>>$Log_File
cd /home/roboshop/catalogue &>>$Log_File


echo "Install the NodeJs Dependencies"
npm install &>>$Log_File
StatusCheck $?



echo "Setup the Catalogue Service"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>$Log_File
StatusCheck $?

systemctl daemon-reload &>>$Log_File
systemctl enable catalogue &>>$Log_File

echo "Start the Service"
systemctl start catalogue &>>$Log_File
StatusCheck $?