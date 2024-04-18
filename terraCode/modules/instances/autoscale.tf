data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_template" "public_launch_template" {
  name                   = "public-launch-template"
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]
}

resource "aws_autoscaling_group" "master_autoscaling_group" {
  name                = "master-autoscaling-group"
  vpc_zone_identifier = var.public_subnet_ids
  desired_capacity    = 1
  min_size            = 1
  max_size            = 1
  
  launch_template {
    id      = aws_launch_template.public_launch_template.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = format("master-%s-%s-server", var.appname, var.env)
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "node_autoscaling_group" {
  name                = "node-autoscaling-group"
  vpc_zone_identifier = var.public_subnet_ids
  desired_capacity    = length(var.public_instance_count) - 1
  min_size            = length(var.public_instance_count) - 1
  max_size            = length(var.public_instance_count) - 1
  
  launch_template {
    id      = aws_launch_template.public_launch_template.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }

  dynamic "tag" {
    for_each = toset(range(length(var.public_instance_count) - 1))
    content {
      key                 = "Name"
      value               = format("node-%s-%s-server", var.appname, var.env)
      propagate_at_launch = true
    }
  }
}
