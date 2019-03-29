output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "subnet_ids" {
  value = "${data.aws_subnet_ids.subnet-ids.ids}"
}