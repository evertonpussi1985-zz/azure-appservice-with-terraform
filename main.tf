resource "azurerm_resource_group" "everton-test" {
  name     = "terraform-resource-group"
  location = "East US"
}

resource "azurerm_app_service_plan" "everton-test" {
  name                = "terraform-appserviceplan"
  location            = "${azurerm_resource_group.everton-test.location}"
  resource_group_name = "${azurerm_resource_group.everton-test.name}"

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "everton-test" {
  name                = "terraform-app-service"
  location            = "${azurerm_resource_group.everton-test.location}"
  resource_group_name = "${azurerm_resource_group.everton-test.name}"
  app_service_plan_id = "${azurerm_app_service_plan.everton-test.id}"

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

}