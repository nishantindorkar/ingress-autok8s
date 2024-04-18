output "node_role_arn" {
  value = aws_iam_role.worker.arn
}

# output "eks_node_role_arn" {
#   value = aws_iam_role.eks_cluster.arn
# }

output "AmazonEKSWorkerNodePolicy_attachment" {
  value = aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy
}

output "AmazonEKS_CNI_Policy_attachment" {
  value = aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
}

output "AmazonEC2ContainerRegistryReadOnly_attachment" {
  value = aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
} 