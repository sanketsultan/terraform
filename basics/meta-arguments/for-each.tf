variable "instances" {
  type = map(string)
  default = {
    web  = "t3.micro"
    api  = "t3.small"
    jobs = "t3.micro"
  }
}

resource "aws_instance" "app" {
  for_each = var.instances

  ami           = "ami-0abcdef1234567890"
  instance_type = each.value

  tags = {
    Name = each.key
  }
}
output "instance_ids" {
  value = { for key, instance in aws_instance.app : key => instance.id }
}

variable "subnets" {
  type = map(string)
  default = {
    public-a = "10.0.1.0/24"
    public-b = "10.0.2.0/24"
    public-c = "10.0.3.0/24"
  }
}

resource "aws_subnet" "sn" {
  for_each = var.subnets

  cidr_block = each.value
  vpc_id     = aws_vpc.main.id

  tags = {
    Name = each.key
  }
}
output "subnet_ids" {
  value = { for key, subnet in aws_subnet.sn : key => subnet.id }
}