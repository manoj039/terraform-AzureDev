output "artifact_repository_id" {
  description ="an identifier for the repository"
  value = google_artifact_registry_repository.my-repo.id
}

output "artifact_repository_name" {
  value = google_artifact_registry_repository.my-repo.name
}