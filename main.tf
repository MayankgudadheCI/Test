variable "access_key" {}
variable "secret_access_key" {}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_access_key
  region     = "ap-south-1"
}

resource "aws_instance" "machine" {
  ami             = "ami-0d1e92463a5acf79d"
  instance_type   = "t2.micro"
  key_name        = "deploy"
  security_group_ids = "sg-0775b034d32553d56"
  user_data = <<-EOF
    #!/bin/bash
    cd /mnt
    wget "https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.94/bin/apache-tomcat-9.0.94.zip"
    unzip apache-tomcat-9.0.94.zip
    chmod -R 777 apache-tomcat-9.0.94

    AWS_DEFAULT_REGION="ap-south-1"
    BUCKET_NAME="deploy-mayank-mumbai"
    OBJECT_KEY="LoginWebApp.war"
    DESTINATION_PATH="/mnt/apache-tomcat-9.0.94/webapps"

    # Configure AWS CLI
    echo "Configuring AWS CLI"
    aws configure set aws_access_key_id "${var.access_key}"
    aws configure set aws_secret_access_key "${var.secret_access_key}"
    aws configure set default.region "$AWS_DEFAULT_REGION"

    if [ $? -ne 0 ]; then
        echo "AWS CLI configuration failed."
        exit 1
    fi

    echo "Downloading object from S3..."
    aws s3 cp s3://$BUCKET_NAME/$OBJECT_KEY $DESTINATION_PATH

    # Check if the download was successful
    if [ $? -eq 0 ]; then
        echo "Download successful."
    else
        echo "Download failed."
        exit 1
    fi

    sudo yum install java-11-amazon-corretto.x86_64 -y
    cd /mnt/apache-tomcat-9.0.94/bin
    ./startup.sh
  EOF

  tags = {
    Name = "Instance-A"
  }
}

# Output the instance ID and public IP for convenience
output "instance_id" {
  value = aws_instance.machine.id
}

output "instance_public_ip" {
  value = aws_instance.machine.public_ip
}
