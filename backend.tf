terraform {
  cloud {

    organization = "ALGroup"

    workspaces {
      name = "Terraform-without-Kube"
    }
  }
}



