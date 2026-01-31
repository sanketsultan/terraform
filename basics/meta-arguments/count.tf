resource "aws_instance" "web" {
  count = 3

  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"

  tags = {
    Name = "web-${count.index}"
  }
}

output "instance_ids" {
  value = [for i in aws_instance.web : i.id]
}

variable "subnet_cidrs" {
  type = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

resource "aws_subnet" "sn" {
  count = length(var.subnet_cidrs)

  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[count.index]

  tags = {
    Name = "subnet-${count.index}"
  }
}
