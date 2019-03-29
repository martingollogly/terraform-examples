variable "region" {}

variable "vpc-cidr" {}
variable "subnet-cidrs" {
  type   = "map"
  default = {
    "0" = "10.10.10.0/27"
    "1" = "10.10.10.32/27"
    "2" = "10.10.10.64/27"
  }
}


variable "azs" {
  type   = "map"
}
