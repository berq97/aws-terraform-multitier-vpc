# Public tier security group — allows inbound HTTP/HTTPS from anywhere, SSH from your IP only
resource "aws_security_group" "public" {
  name        = "${var.project_name}-public-sg"
  description = "Security group for public tier resources"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from my IP only"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-public-sg"
  }
}

# Private tier security group — only allows traffic from the public tier security group
resource "aws_security_group" "private" {
  name        = "${var.project_name}-private-sg"
  description = "Security group for private tier resources"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow traffic from public tier only"
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-private-sg"
  }
}