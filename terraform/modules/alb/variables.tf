variable "name_prefix" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "health_check_path" {
  type    = string
  default = "/health"
}

