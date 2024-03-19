# Terraform variables to launch new clusters

region = "us-gov-west-1"
aws_region = "us-gov-west-1"
user_aws_profile = "vdms"
environment = "prod"

image = "179381774813.dkr.ecr.us-gov-west-1.amazonaws.com/ironbank-rhel9-base"

cluster_name = "vdms-prod-v1"
cluster_version = "1.27"

# Backup autoscaling groups names
group_name_1 = "v1-sm1"
group_name_2 = "v1-sm2"

eks_vpc_id = "vpc-20ce4744"
eks_subnet_ids = ["subnet-1aafe67e", "subnet-853d75f3"]
eks_vpc_cidr = "10.22.0.0/16"

fluentbit_s3_bucket = "vdms-prod-v1-fluent-bit"

mapUsers = [
  {
    userarn  = "arn:aws-us-gov:iam::179381774813:role/OrganizationAdminAccessRole"
    username = "OrganizationAdminAccessRole"
    groups   = ["system:masters"]
  },
  {
    userarn  = "arn:aws-us-gov:iam::179381774813:role/OrganizationAccountAccessRole"
    username = "OrganizationAccountAccessRole"
    groups   = ["system:masters"]
  }
]

# Node EC2 userdata addition. Leave as is if there is nothing here you need to add.
post_bootstrap_user_data_var = <<-EOT
ls -l /etc/kubernetes/kubelet/kubelet-config.json
EOT

# EKS Endpoint Access
cluster_endpoint_public_access_cidrs_var = ["140.17.80.138/32"]
