resource "aws_vpc" "main" {
  cidr_block = var.vpc-config.cidr_block
  tags = {
    Name = var.vpc-config.name
  }
}
resource "aws_subnet" "main" {
  vpc_id = aws_vpc.main.id
  for_each = var.subnet-config  #key={cidr, az} each.key each.value

  cidr_block = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = each.key
  }
}

locals {
  public_subnet = {
    for key, config in var.subnet-config : key => config if config.public
  }
  private_subnet = {
    for key, config in var.subnet-config : key => config if !config.public
  }
}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  count = length(local.public_subnet) > 0 ? 1 : 0   #create a internet gateway if user provide 'public = true'
}

resource "aws_route_table" "main" {
  count = length(local.public_subnet) > 0 ? 1 : 0
  vpc_id = aws_vpc.main.id
  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main[0].id
  }
}
resource "aws_route_table_association" "main" {
  for_each = local.public_subnet
  
  subnet_id = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.main[0].id
}