#!/bin/bash
sudo yum install java-11-amazon-corretto.x86_64 -y
cd /mnt
wget "https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.94/bin/apache-tomcat-9.0.94.zip"
unzip apache-tomcat-9.0.94.zip
chmod -R 777 apache-tomcat-9.0.94

AWS_DEFAULT_REGION="${aws_region}"
BUCKET_NAME="${bucket_name}"
OBJECT_KEY="${object_key}"
DESTINATION_PATH="/mnt/apache-tomcat-9.0.94/webapps"

# Configure AWS CLI
echo "Configuring AWS CLI"
aws configure set aws_access_key_id "${access_key}"
aws configure set aws_secret_access_key "${secret_access_key}"
aws configure set default.region "$AWS_DEFAULT_REGION"

echo "Downloading object from S3..."
aws s3 cp s3://deploy-mayank-mumbai/LoginWebApp.war /mnt/apache-tomcat-9.0.94/webapps

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Download successful."
else
    echo "Download failed."
    exit 1
fi
# Start Tomcat
echo "Starting Tomcat..."
cd /mnt/apache-tomcat-9.0.94/bin/
./startup.sh
sleep 10
cd /mnt/apache-tomcat-9.0.94/bin/
./shutdown.sh 
sleep 10
cd /mnt/apache-tomcat-9.0.94/bin/
./startup.sh
sleep 10