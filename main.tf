terraform {
  required_version = ">= 1.0"
  backend "s3" {
    bucket  = "test-backstage-anav1"
    key     = "atlantis/terraform.tfstate"
    region  = "sa-east-1"
    profile = "default"
  }
}

provider "aws" {
  region  = "sa-east-1"
  profile = "default"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # ID oficial do Ubuntu
  owners = ["099720109477"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-atlantis"
  }
}