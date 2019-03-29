# The us-east-1 provider used to provision ACM cert and R53 HZ
provider "aws" {
  region  = "us-east-1"
  version = "1.26.0"
  alias   = "us-east-1"
}

provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = ""
    key    = ""
    region = "eu-west-1"
  }
}


module "vpc_vpc1" {
  source   = "../modules//network//vpc1/"
  region = "${var.region}"
  vpc-cidr = "${var.vpc-cidr}"
  subnet-cidrs = "${var.subnet-cidrs}"
  azs          = "${var.azs}"
}

module "alb" {
  source              = "../modules//alb/"
  vpc_id              = "${module.vpc_vpc1.vpc_id}"
  environment         = "${var.environment}"
  allowed_cidr_blocks = "10.10.10.0/27"
  subnet_ids          = "${module.vpc_vpc1.subnet_ids}" 
}


 module "ec2" {
   source   = "../modules//ec2/"
   vpc-id = "${module.vpc_vpc1.vpc_id}"
   subnet-id = "${module.vpc_vpc1.subnet_ids}"
 }
