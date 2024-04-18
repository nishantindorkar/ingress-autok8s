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

variable "AmazonEKSWorkerNodePolicy_attachment" {
  type = string
  default = "AmazonEKSWorkerNodePolicy"
}

variable "AmazonEKS_CNI_Policy_attachment" {
  type = string
  default = "AmazonEKS_CNI_Polic"
}

variable "AmazonEC2ContainerRegistryReadOnly_attachment" {
  type = string
  default = "AmazonEC2ContainerRegistryReadOnly"
}

variable "eks_cluster_name" {
  type = string
  default = "pc-eks"
}