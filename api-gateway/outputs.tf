# outputs.tf
output "app_service_url" {
  value = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "apim_gateway_url" {
  value = "https://${azurerm_api_management.main.gateway_url}"
}

output "api_url" {
  value = "https://${azurerm_api_management.main.gateway_url}/demo"
}
