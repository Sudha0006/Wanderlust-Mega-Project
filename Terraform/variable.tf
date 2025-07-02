variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "ec2_instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.large"
}

variable "ec2_default_root_storage_size" {
  description = "EBS volume size"
  type        = number
  default     = 20
}

variable "ec2_ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0f918f7e67a3323f0"
}

~
