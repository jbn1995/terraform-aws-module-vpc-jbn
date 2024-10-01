## Terraform-aws-vpc

## Overview

This Terraform module creates an AWS vpc with a given CIDR block. It also creates multiple subnets(public and private), and for public subnets it sets up an Internet Gateway(IGW) and appropriate route tables.

## Features

- Creates a VPC with a Specified CIDR block
- Create public and private subnets
- Creates a Internet Gateway
- Set up route tables for public subnet

## Usage
```
module "vpc" {
  source = "./module/vpc"

  vpc-config = {
    cidr_block = "20.0.0.0/16"
    name       = "your vpc name"
  }
  subnet-config = {
    public_subnet-1 = {
      cidr_block = "20.0.1.0/24"
      az         = "ap-south-1a"
      # To set the subnet as public, default is private
      public     = true 
    }
    public_subnet-2 = {
      cidr_block = "20.0.0.0/24"
      az         = "ap-south-1a"
      public     = true 
    }
    private_subnet = {
      cidr_block = "20.0.2.0/24"
      az         = "ap-south-1b"
    }
  }
}
```
