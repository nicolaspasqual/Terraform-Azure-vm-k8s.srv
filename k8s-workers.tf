resource "azurerm_public_ip" "Worker-public_ip" {
  count               = var.worker_count
  name                = "${var.env}-Worker-${count.index}-IP"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = "Dynamic"

  tags = local.tags
}

data "azurerm_public_ip" "Worker-data_public_ip" {
  count               = var.worker_count
  name                = azurerm_public_ip.Worker-public_ip[count.index].name
  resource_group_name = azurerm_linux_virtual_machine.Worker-ubuntu[count.index].resource_group_name
}


resource "azurerm_network_interface" "Worker-net_interface" {
  count               = var.worker_count
  name                = "${var.env}-Worker-${count.index}-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.Worker-public_ip[count.index].id
  }

  tags = local.tags
}


resource "azurerm_linux_virtual_machine" "Worker-ubuntu" {
  count               = var.worker_count
  name                  = "${var.env}-Worker-${count.index}"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = var.location
  size                  = "Standard_B2s"
  admin_username        = "terraform"
  network_interface_ids = [azurerm_network_interface.Worker-net_interface[count.index].id]

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

  connection {
    type        = "ssh"
    user        = "terraform"
    private_key = file("~/.ssh/id_rsa")
    host        = self.public_ip_address
  }

  provisioner "file" {
    source      = "install-k8s-worker-script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
  }
}


