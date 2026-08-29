variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "ap-south-1"
}
variable "db_password" {
  description = "Password for the PostgreSQL RDS instance"
  type        = string
  sensitive   = true
}
variable "image_tag" {
  description = "Docker image tag used by ECS"
  type        = string
  default     = "latest"
}