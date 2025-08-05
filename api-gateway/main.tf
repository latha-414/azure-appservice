# main.tf
resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

resource "azurerm_resource_group" "main" {
  name     = "rg-apim-demo"
  location = var.location
}

resource "azurerm_service_plan" "main" {
  name                = "asp-demo"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "main" {
  name                = "app-demo-${random_integer.suffix.result}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    application_stack {
      node_version = "18-lts"
    }
  }
}

resource "azurerm_api_management" "main" {
  name                = "apim-demo-${random_integer.suffix.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  publisher_name      = "Demo Publisher"
  publisher_email     = var.publisher_email
  sku_name           = "Developer_1"
}

resource "azurerm_api_management_api" "main" {
  name                = "demo-api"
  resource_group_name = azurerm_resource_group.main.name
  api_management_name = azurerm_api_management.main.name
  revision            = "1"
  display_name        = "Demo API"
  path                = "demo"
  protocols           = ["https"]
  service_url         = "https://${azurerm_linux_web_app.main.default_hostname}"
}

# Add GET operation
resource "azurerm_api_management_api_operation" "get_test" {
  operation_id        = "get-test"
  api_name           = azurerm_api_management_api.main.name
  api_management_name = azurerm_api_management.main.name
  resource_group_name = azurerm_resource_group.main.name
  display_name       = "GET Test"
  method             = "GET"
  url_template       = "/test"
}

# Add POST operation  
resource "azurerm_api_management_api_operation" "post_test" {
  operation_id        = "post-test"
  api_name           = azurerm_api_management_api.main.name
  api_management_name = azurerm_api_management.main.name
  resource_group_name = azurerm_resource_group.main.name
  display_name       = "POST Test"
  method             = "POST"
  url_template       = "/test"
}
