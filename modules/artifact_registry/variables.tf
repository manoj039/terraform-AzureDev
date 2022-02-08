variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "region" {
	description = "region where repository need to store"
  	type = string
}

variable "repository_id" {
	description = "repository name/id"
  type = string
}

variable "format" {
	description = "type of repository DOCKER or pip or other package"
	type = string
}

variable "repo_description" {
	default=""
}