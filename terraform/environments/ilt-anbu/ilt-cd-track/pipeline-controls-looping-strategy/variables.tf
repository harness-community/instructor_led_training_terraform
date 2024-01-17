variable "harness_account_id" {
  description = "ID of the Harness Account."
  type        = string
}

variable "harness_org_id" {
  description = "ID of the Harness Organization."
  type        = string
}

variable "harness_student_project" {
  description = "ID of the Harness Project - student sandbox level."
  type        = string
}

variable "harness_platform_api_key" {
  description = "PAT of the Harness, at the Account level."
  type        = string
}