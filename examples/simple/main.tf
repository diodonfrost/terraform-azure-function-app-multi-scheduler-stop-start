resource "random_pet" "suffix" {}

module "terraform-azure-function-app-multi-scheduler-stop-start" {
  source = "../.."
}
