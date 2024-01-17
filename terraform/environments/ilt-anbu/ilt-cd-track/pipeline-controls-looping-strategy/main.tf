resource "harness_platform_pipeline" "example" {
  identifier = "looping_strategies"
  org_id     = var.harness_org_id
  project_id = var.harness_student_project
  name       = "Looping Strategies"

  yaml = file("harness-manifests-and-yamls/test-pipeline.yaml")
}