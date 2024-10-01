provider "aws" {
  region = "ap-south-1"
}
module "vpc" {
  source = "./module/vpc"

  vpc-config = {
    cidr_block = "20.0.0.0/16"
    name       = "test-vpc"
  }
  subnet-config = {
    public_subnet-1 = {
      cidr_block = "20.0.1.0/24"
      az         = "ap-south-1a"
      public     = true # if true that an internet gateway will be created for this public-subnet
    }
    public_subnet-2 = {
      cidr_block = "20.0.0.0/24"
      az         = "ap-south-1a"
      public     = true # if true that an internet gateway will be created for this public-subnet
    }
    private_subnet = {
      cidr_block = "20.0.2.0/24"
      az         = "ap-south-1b"
    }
  }
}
