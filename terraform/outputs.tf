output "cluster_name" {
  value = module.eks.cluster_id
}

output "ecr_repo_url" {
  value = aws_ecr_repository.app.repository_url
}

