resource "azurerm_public_ip" "public_ip2" {
  name                = "K8s2-PublicIP"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = "Dynamic"

  tags = local.tags

  provisioner "local-exec" {
    command = "echo ${self.ip_address} >> ../ansible/hosts"
  }
}

resource "azurerm_network_interface" "net_interface2" {
  name                = "K8s2-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip2.id
  }

  tags = local.tags
}

resource "azurerm_linux_virtual_machine" "ubuntu_vm2" {
  name                  = "K8s2-VM"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  size                  = "Standard_B2s"
  admin_username        = "terraform"
  network_interface_ids = [azurerm_network_interface.net_interface2.id]

  admin_ssh_key {
    username   = "terraform"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  tags = local.tags

}

data "azurerm_public_ip" "data_public_ip2" {
  name                = azurerm_public_ip.public_ip2.name
  resource_group_name = azurerm_linux_virtual_machine.ubuntu_vm2.resource_group_name
}