# VPC1  

* 1 x VPC
* 2 x Public subnets
* 2 x NAT gateways
* 2 x Private subnets

## Usage

```
module "vpc_vpc1" {
  source   = "../modules//network//vpc1/"
  region = "${var.region}"
  vpc-cidr = "${var.vpc-cidr}"
  subnet-cidr-a = "${var.subnet-cidr-a}"
  subnet-cidr-b = "${var.subnet-cidr-b}"
  subnet-cidr-c = "${var.subnet-cidr-c}"
}

```

## TODO

* Make Subnets a dynamic list