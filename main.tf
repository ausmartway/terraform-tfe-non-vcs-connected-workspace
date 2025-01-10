##main.tf
resource "github_repository" "repo" {
  name        = var.name
  description = "Github repository for TFC workspace ${var.name}"
  visibility = "private"
  template {
    owner      = var.github_owner
    repository = var.template_repo
  }
}

resource "github_repository_file" "backend" {
  repository = github_repository.repo.name
  file = "backend.tf"
  content = templatefile("${path.module}/backend.tpl",{org = var.organization,wsname=var.name})
  commit_message = "deault backend.tf"
}


resource "tfe_workspace" "workspace" {
  description           = var.workspace_description
  allow_destroy_plan    = true
  auto_apply            = true
  file_triggers_enabled = false
  # global_remote_state   = false
  name = var.name
  organization                  = var.organization
  queue_all_runs                = true
  speculative_enabled           = true
  structured_run_output_enabled = true
  tag_names                     = var.tags
  terraform_version             = var.terraform_version
  trigger_prefixes              = []
}