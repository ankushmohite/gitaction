# Key Pair Login

resource "aws_key_pair" "demo-key" {
  key_name   = "terra-key"
  public_key = file("terra-key.pub")


  }

# Create Vpc & Security group

resource "aws_default_vpc" "default" {
  
}

resource "aws_security_group" "allow_tls" {
  name        = "terra-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id # Interviewse ask --> interpolation -->  interpolation is a way in which we can extract the values from terraform block

# inbound rules
ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



# Outbound rules
egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocals access.
    cidr_blocks = ["0.0.0.0/0"]
  }

tags = {
    Name = "terra-security-group"
  }

}
  
# ec2_instance

resource "aws_instance" "my-instance" {
  key_name = aws_key_pair.demo-key.key_name
  security_groups = [aws_security_group.allow_tls.name]
  instance_type = "t2.micro"
  ami = "ami-0a14f53a6fe4dfcd1"
  tags = {
    Name = "HelloWorld"
  }

  root_block_device {
    volume_size = 8
    volume_type = "gp2"

  }
  
}

