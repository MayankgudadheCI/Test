
variable "access_key" {}
variable "secret_access_key" {}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_access_key
  region     = "ap-south-1"
}

resource "aws_security_group" "custom" {
  name        = "custom-security-group"
  description = "Custom security group in the default VPC"
  vpc_id      = data.aws_vpc.default.id

  # Ingress rules
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "custom-security-group"
  }
}

resource "aws_instance" "machine" {
  ami                    = "ami-0d1e92463a5acf79d"
  instance_type          = "t2.micro"
  key_name               = "deploy"
  vpc_security_group_ids = [aws_security_group.custom.id]
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

  EOF

  tags = {
    Name = "Instance-A"
  }
}
