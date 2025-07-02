 Key Pair (for login)
resource "aws_key_pair" "my_key_new" {
  key_name   = "terra-key-ec2"
  public_key = file("/home/ubuntu/bigproject/Wanderlust-Mega-Project/terraform/terra-key.pub")

}

# Default VPC
resource "aws_default_vpc" "default" {}

# Security Group
resource "aws_security_group" "my_security_group" {
  name        = "automate-sg-unique"
  description = "Security group for EC2"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH Access"
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Flask App"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
 }

  tags = {
    Name = "automate-sg-unique"
  }
}

# ✅ EC2 Instance (Single)
resource "aws_instance" "my_instance" {
  ami                    = var.ec2_ami_id
  instance_type          = var.ec2_instance_type
  key_name               = aws_key_pair.my_key_new.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

  root_block_device {
    volume_size = var.ec2_default_root_storage_size
    volume_type = "gp3"
  }

  tags = {
    Name = "tws-automate"
