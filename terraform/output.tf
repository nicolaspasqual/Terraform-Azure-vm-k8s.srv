output "rg_id" {
  value = azurerm_resource_group.rg.id
}

output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}

output "public_ip_address_1" {
  value = data.azurerm_public_ip.data_public_ip1.ip_address
}

output "public_ip_address_2" {
  value = data.azurerm_public_ip.data_public_ip2.ip_address
}