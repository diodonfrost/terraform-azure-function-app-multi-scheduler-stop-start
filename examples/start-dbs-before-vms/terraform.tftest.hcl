run "validate_creation" {
  command = apply

  assert {
    condition     = module.multi_scheduler.resource_group_name == azurerm_resource_group.test.name
    error_message = "Resource group name should be the same as the module resource group name"
  }

  assert {
    condition     = azurerm_resource_group.test.location == "swedencentral"
    error_message = "Resource group should be in swedencentral region"
  }

  assert {
    condition     = module.multi_scheduler.service_plan_id != ""
    error_message = "Service plan should be created"
  }

  assert {
    condition     = module.multi_scheduler.storage_account_id != ""
    error_message = "Storage account should be created"
  }

  assert {
    condition     = contains(keys(module.multi_scheduler.schedulers), "azure-vms-stop")
    error_message = "Should contain 'azure-vms-stop' scheduler"
  }

  assert {
    condition     = contains(keys(module.multi_scheduler.schedulers), "azure-vms-start")
    error_message = "Should contain 'azure-vms-start' scheduler"
  }

  assert {
    condition     = contains(keys(module.multi_scheduler.schedulers), "azure-dbs-stop")
    error_message = "Should contain 'azure-dbs-stop' scheduler"
  }

  assert {
    condition     = contains(keys(module.multi_scheduler.schedulers), "azure-dbs-start")
    error_message = "Should contain 'azure-dbs-start' scheduler"
  }

  assert {
    condition     = can(regex("stop-vms-at-night-", module.multi_scheduler.schedulers["azure-vms-stop"].function_app_name))
    error_message = "VM stop scheduler function app name should contain 'stop-vms-at-night-'"
  }

  assert {
    condition     = can(regex("start-vms-at-morning-", module.multi_scheduler.schedulers["azure-vms-start"].function_app_name))
    error_message = "VM start scheduler function app name should contain 'start-vms-at-morning-'"
  }

  assert {
    condition     = can(regex("stop-dbs-at-night-", module.multi_scheduler.schedulers["azure-dbs-stop"].function_app_name))
    error_message = "DB stop scheduler function app name should contain 'stop-dbs-at-night-'"
  }

  assert {
    condition     = can(regex("start-dbs-at-morning-", module.multi_scheduler.schedulers["azure-dbs-start"].function_app_name))
    error_message = "DB start scheduler function app name should contain 'start-dbs-at-morning-'"
  }
}
