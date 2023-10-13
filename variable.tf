variable "reg" {
  description = "The region for creating the resources"
  default     = "ap-south-1"
}

variable "ak" {
  description = "Access key of the IAM User"
  default     = "AKIAZANDQIRABD4RV2WB"
}

variable "sk" {
  description = "Secret key of the IAM User"
  default     = "n5Kn6O9CV3YtaG68CiUaEZk+WmMVAKJQH2SBYAYm"
}

variable "ami_id" {
  description = "Ami_id of the operating system"
  default     = "ami-08e5424edfe926b43"
}

variable "keypair" {
  description = "Keypair that should be associated with the instance"
  default     = "console_server"
}
