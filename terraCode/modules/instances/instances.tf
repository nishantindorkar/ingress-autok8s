data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    #ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*
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

# resource "aws_instance" "public_instance" {
  # count                       = length(var.public_instance_count)
  # ami                         = data.aws_ami.ubuntu.id
  # instance_type               = var.instance_type
  # key_name                    = var.key_name
  # vpc_security_group_ids      = [var.security_group_id]
  # subnet_id                   = var.public_subnet_ids[count.index]
  # tags = merge(var.tags,{Name = format("%s-%s-%s-server-${count.index + 1}","public",var.appname,var.env)})
# }

resource "aws_instance" "kubectl-server" {
    count                       = length(var.public_instance_count)
    ami                         = data.aws_ami.ubuntu.id
    instance_type               = var.instance_type
    key_name                    = var.key_name
    vpc_security_group_ids      = [var.security_group_id]
    subnet_id                   = var.public_subnet_ids[count.index]
    tags = merge(var.tags,{Name = format("%s-%s-%s-server-${count.index + 1}","public",var.appname,var.env)})
    associate_public_ip_address = true
  }

  resource "aws_eks_node_group" "node-grp" {
    count           = length(var.public_instance_count)
    cluster_name    = var.eks_cluster_name
    node_group_name = "pc-node-group"
    node_role_arn   = var.node_role_arn
    subnet_ids      = [var.public_subnet_ids[count.index]]
    capacity_type   = "ON_DEMAND"
    disk_size       = 20
    instance_types  = ["t2.small"]

    remote_access {
      ec2_ssh_key               = "pyapp"
      source_security_group_ids = [var.security_group_id]
    }

    labels = {
      env = "dev"
    }

    scaling_config {
      desired_size = 2
      max_size     = 2
      min_size     = 1
    }

    update_config {
      max_unavailable = 1
    }

    depends_on = [
      var.AmazonEKSWorkerNodePolicy_attachment,
      var.AmazonEKS_CNI_Policy_attachment,
      var.AmazonEC2ContainerRegistryReadOnly_attachment,
    ]
  }