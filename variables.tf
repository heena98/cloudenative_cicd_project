variable "jenkins_ami" {
  description = "AMI ID for Jenkins EC2 instance (Amazon Linux 2 recommended)"
  type        = string
  default     = "ami-0c101f26f147fa7fd" # Amazon Linux 2 for us-east-1
}

variable "jenkins_instance_type" {
  description = "Instance type for Jenkins EC2"
  type        = string
  default     = "t2.micro"
}


variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
  default     = "demoproject"
}

