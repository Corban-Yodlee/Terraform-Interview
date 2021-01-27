module "cluster-one" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "cluster-one"
  cluster_version = "1.17"
  subnets         = [
    aws_subnet.a.id,
    aws_subnet.b.id,
    aws_subnet.c.id,
  ]
  vpc_id          = "vpc-0a2aa6d7a68dce461"

  worker_groups = [
    {
      instance_type = "m5.large"
      asg_max_size  = 3
    }
  ]
}

module "cluster-two" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "cluster-two"
  cluster_version = "1.17"
  subnets         = [
    aws_subnet.a.id,
    aws_subnet.b.id,
    aws_subnet.c.id,
  ]
  vpc_id          = "vpc-0a2aa6d7a68dce461"

  worker_groups = [
    {
      instance_type = "m5.large"
      asg_max_size  = 3
    }
  ]
}