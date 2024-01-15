resource "null_resource" "harness_delegate" {
  provisioner "local-exec" {
    command = "../../../../scripts/deploy_harness_delegate_to_project.sh ${var.harness_account_id} ${var.harness_org_id} ${var.harness_student_project} ${var.harness_pat}"

    environment = {
      DELEGATE_OWNER = "gabs"
      # ... other environment variables
    }
  }
}

data "external" "script_output" {
  # Ensure this only runs after null_resource.harness_delegate
  depends_on = [null_resource.harness_delegate]
  
  program = ["cat", "./helper.json"]
}

output "delegate_id" {
  value = data.external.script_output.result["delegate_name"]
}

# PART TO HANDLE TERRAFORM DESTROY BY GABS
resource "null_resource" "harness_delegate_cleanup" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "../../../../scripts/destroy_harness_delegate_in_project.sh"
  }
}
