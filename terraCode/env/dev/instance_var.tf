variable "appname" {
  type    = string
  default = "web"
}
variable "env" {
  type    = string
  default = "development"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "key_name" {
  type    = string
  default = "pyapp"
}
variable "internal" {
  type    = bool
  default = false
}
variable "type" {
  type    = string
  default = "application"
}

variable "eks_cluster_name" {
  type    = string
  default = "aws_eks_cluster.eks.name"
}

variable "worker_node_role_arn" {
  type    = string
  default = "aws_iam_role.worker.arn"
}