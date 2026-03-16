terraform {
  cloud {
    organization = "TU_ORG"

    workspaces {
      name = "iac-ecs-fargate-prod"
    }
  }
}

