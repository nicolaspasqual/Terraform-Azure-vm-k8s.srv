output "public_ip_address_master" {
  value = data.azurerm_public_ip.Master-data_public_ip.ip_address
}

# output "public_ip_address_worker1" {
#   value = data.azurerm_public_ip.Worker-data_public_ip[0].ip_address
# }

# output "public_ip_address_worker2" {
#   value = data.azurerm_public_ip.Worker-data_public_ip[1].ip_address
# }

# output "public_ip_address_worker3" {
#   value = data.azurerm_public_ip.Worker-data_public_ip[2].ip_address
# }