terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "${org}"
    workspaces {
      name = "${wsname}"
    }
  }
}