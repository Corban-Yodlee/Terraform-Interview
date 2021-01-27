resource "aws_vpc" "interview" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "allow_outgoing" {
  name        = "allow_egress_only"
  description = "Allows out non-existant lambda to make calls out but not recieve any incoming connections"
  vpc_id      = aws_vpc.interview.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_outgoing"
  }
}

resource "aws_subnet" "a" {
  vpc_id     = "vpc-0a2aa6d7a68dce461"
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "b" {
  vpc_id     = "vpc-0a2aa6d7a68dce461"
  cidr_block = "10.1.0.0/24"
}

resource "aws_subnet" "c" {
  vpc_id     = "vpc-0a2aa6d7a68dce461"
  cidr_block = "10.0.2.0/24"
}
