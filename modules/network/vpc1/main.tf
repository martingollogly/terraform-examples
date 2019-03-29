resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc-cidr}"
  enable_dns_hostnames = true
}



# Public Subnets
resource "aws_subnet" "subnet" {
  count             = "${length(var.subnet-cidrs)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.subnet-cidrs[count.index]}"
  availability_zone = "${var.region}${var.azs[count.index]}]}"
}


resource "aws_route_table" "subnet-route-table" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route" "subnet-route" {
  destination_cidr_block  = "0.0.0.0/0"
  gateway_id              = "${aws_internet_gateway.igw.id}"
  route_table_id          = "${aws_route_table.subnet-route-table.id}"
}

data "aws_subnet_ids" "subnet-ids" {
  vpc_id = "${aws_vpc.vpc.id}"
}

# resource "aws_route_table_association" "subnet-route-table-association" {
#   count         = "${length(data.aws_subnet_ids.subnet-ids.subnet_id)}"
#   subnet_id      = "${lookup(data.aws_subnet_ids.subnet-ids.subnet_id)}"
#   route_table_id = "${aws_route_table.subnet-route-table.id}"
# }