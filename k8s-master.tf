resource "azurerm_public_ip" "Master-public_ip" {
  name                = "${var.env}-Master-IP"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = "Dynamic"

  tags = local.tags
}

data "azurerm_public_ip" "Master-data_public_ip" {
  name                = azurerm_public_ip.Master-public_ip.name
  resource_group_name = azurerm_linux_virtual_machine.Master-ubuntu.resource_group_name
}


resource "azurerm_network_interface" "Master-net_interface" {
  name                = "${var.env}-Master-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.Master-public_ip.id
  }

  tags = local.tags
}


resource "azurerm_linux_virtual_machine" "Master-ubuntu" {
  name                  = "${var.env}-Master"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  size                  = "Standard_B2s"
  admin_username        = "terraform"
  network_interface_ids = [azurerm_network_interface.Master-net_interface.id]

  admin_ssh_key {
    username   = "terraform"
    public_key = file(var.pub-key)
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

  connection {
    type        = "ssh"
    user        = "terraform"
    private_key = file(var.pv-key)
    host        = self.public_ip_address
  }

  provisioner "file" {
    source      = "install-k8s-master-script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
  }

  provisioner "local-exec" {
    command = "ssh -oStrictHostKeyChecking=no terraform@${self.public_ip_address} 'kubeadm token create --print-join-command' > join-cmd.sh"
  }

}