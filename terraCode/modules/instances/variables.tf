variable "instance_type" {
  type = string
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "env" {
  type = string
}

variable "appname" {
  type = string
}

variable "key_name" {
  type = string
}
variable "tags" {
  type = map(string)
  default = {
    Name = "other"
  }
}
variable "public_instance_count" {
  type = list(string)
}

variable "node_role_arn" {
  type = string
}

variable "cluster_name" {
  type = string
  default = "eks-test"
}

variable "AmazonEKSWorkerNodePolicy_attachment" {
  type = string
}

variable "AmazonEKS_CNI_Policy_attachment" {
  type = string
}

variable "AmazonEC2ContainerRegistryReadOnly_attachment" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}