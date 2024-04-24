variable "public_subnet_ids" {
  type = list(string)
}

variable "key_name" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "eks_cluster_name" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "public_instance_count" {
  type = list(string)
}