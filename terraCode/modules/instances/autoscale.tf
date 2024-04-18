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

resource "aws_autoscaling_group" "public_autoscaling_group" {
  name                = "public-autoscaling-group"
  vpc_zone_identifier = var.public_subnet_ids
  desired_capacity    = length(var.public_instance_count)
  min_size            = length(var.public_instance_count)
  max_size            = length(var.public_instance_count)
  
  launch_template {
    id      = aws_launch_template.public_launch_template.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = format("Master-%s-%s-server", var.appname, var.env)
    propagate_at_launch = true
  }
}