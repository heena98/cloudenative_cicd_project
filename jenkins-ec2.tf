resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow SSH and Jenkins web access"
  vpc_id      = aws_vpc.eks_vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Jenkins web UI"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sg"
  }
}
resource "aws_instance" "jenkins_ec2" {
  ami           = var.jenkins_ami
  instance_type = var.jenkins_instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.eks_subnet[0].id
vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
 
  tags = {
    Name = "jenkins-ec2"
  }
}
