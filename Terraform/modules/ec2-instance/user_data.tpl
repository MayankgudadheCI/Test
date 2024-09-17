#!/bin/bash
cd /mnt
yum install -y wget unzip
wget "https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.94/bin/apache-tomcat-9.0.94.zip"
unzip apache-tomcat-9.0.94.zip
chmod -R 777 apache-tomcat-9.0.94

AWS_DEFAULT_REGION="ap-south-1"
BUCKET_NAME="${bucket_name}"
OBJECT_KEY="${object_key}"
DESTINATION_PATH="/mnt/apache-tomcat-9.0.94/webapps"

echo "Downloading object from S3..."
aws s3 cp s3://$BUCKET_NAME/$OBJECT_KEY $DESTINATION_PATH

if [ $? -eq 0 ]; then
    echo "Download successful."
else
    echo "Download failed."
    exit 1
fi

yum install -y java-11-amazon-corretto
echo "Starting Tomcat..."
cd /mnt/apache-tomcat-9.0.94/bin/
./startup.sh
sleep 10
./shutdown.sh
sleep 10
./startup.sh
sleep 10
