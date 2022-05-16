# create vcp
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "${var.cluster_name}-VPC"
  }
}


# PUBLIC SUBNET 1 RESOURCES
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.vpc_public_subnet1_cidr
  availability_zone       = var.vpc_az1
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.cluster_name}-pubSub1"
  }
}

# PUBLIC SUBNET 2 RESOURCES
resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.vpc_public_subnet2_cidr
  availability_zone       = var.vpc_az2
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.cluster_name}-pubSub2"
  }
}

# PRIVATE SUBNET 1 RESOURCES
resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.vpc_private_subnet1_cidr
  availability_zone       = var.vpc_az1
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.cluster_name}-prisub1"
  }
}

# PRIVATE SUBNET 2 RESOURCES
resource "aws_subnet" "private_subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.vpc_private_subnet2_cidr
  availability_zone       = var.vpc_az2
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.cluster_name}-priSub2"
  }
}

# DB SUBNET 1 RESOURCES
resource "aws_subnet" "db_subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.vpc_db_subnet1_cidr
  availability_zone       = var.vpc_az1
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.cluster_name}-dbsub1"
  }
}

# DB SUBNET 2 RESOURCES
resource "aws_subnet" "db_subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.vpc_db_subnet2_cidr
  availability_zone       = var.vpc_az2
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.cluster_name}-dbsub2"
  }
}

# Create internet gateway for public subnet
resource "aws_internet_gateway" "gw" {
  vpc_id     = aws_vpc.main.id
  
    tags = {
    Name = "${var.cluster_name}-IntGW"
  }
}


# Create public route for public subnets
resource "aws_route_table" "Public_internet_route" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.cluster_name}-Pubroute"
  }
}

# public sub 1 assos
resource "aws_route_table_association" "Public_sub1_Int_asso" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.Public_internet_route.id
}

#Publucsubnet 2 assos
resource "aws_route_table_association" "Public_sub2_int_asso" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.Public_internet_route.id
}


# elastic Ip for nat gateway 1
resource "aws_eip" "nat_gw1" {
  vpc        = true
  
}
# Nat gateway 1
resource "aws_nat_gateway" "nat_gw1" {
  allocation_id = aws_eip.nat_gw1.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    Name = "${var.cluster_name}-natgw1"
  }
}

#Priviate subnet route to Nat1
resource "aws_route_table" "private_route1" {
  vpc_id = aws_vpc.main.id
  # enable route from privite subnets to the nat gateway only
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw1.id
  }
  tags = {
    Name = "${var.cluster_name}-private_route1"
  }
}

resource "aws_route_table_association" "private_subnet1_asso" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route1.id
}

#db sub 1 asso
resource "aws_route_table_association" "db_sub1_asso" {
  subnet_id      = aws_subnet.db_subnet1.id
  route_table_id = aws_route_table.private_route1.id
}

#elastic Ip for nat gateway 2
resource "aws_eip" "nat_gw2" {
  vpc        = true
 }

# Nat gateway 2
resource "aws_nat_gateway" "nat_gw2" {
  allocation_id = aws_eip.nat_gw2.id
  subnet_id     = aws_subnet.public_subnet2.id

  tags = {
    Name = "${var.cluster_name}-natgw2"
  }
}
resource "aws_route_table" "private_route2" {
  vpc_id = aws_vpc.main.id
  # enable route from db subnets to the nat gateway only
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw2.id
  }
  tags = {
    Name = "${var.cluster_name}-private_route2"
  }

}

#db sub 1 ass
resource "aws_route_table_association" "private_subnet2_asso" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route2.id
}
#db sub 2 ass
resource "aws_route_table_association" "db_sub2_asso" {
  subnet_id      = aws_subnet.db_subnet2.id
  route_table_id = aws_route_table.private_route2.id
}




