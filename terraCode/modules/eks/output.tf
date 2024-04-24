output "node_role_arn" {
  value = aws_iam_role.worker.arn
}

# output "eks_node_role_arn" {
#   value = aws_iam_role.eks_cluster.arn
# }

output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "worker_node_role_arn" {
  description = "The ARN of the IAM role for the EKS worker nodes"
  value       = aws_iam_role.worker.arn
}