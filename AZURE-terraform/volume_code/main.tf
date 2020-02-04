resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-${var.name}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  depends_on = ["azurerm_resource_group.main"]

}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "10.0.2.0/24"

  depends_on = ["azurerm_resource_group.main"]
}

resource "azurerm_network_interface" "main" {
  count               = 1
  name                = "${var.prefix}-nic-${count.index+1}"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.internal.id}"
    private_ip_address_allocation = "Dynamic"
  }
}

# ADDITIONAL VOLUME
resource "azurerm_managed_disk" "disk" {
    name = "managed_disk"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.main.name}"
    storage_account_type = "STANDARD_LRS"
    create_option = "Empty"
    disk_size_gb = 10
}


resource "azurerm_virtual_machine" "core" {

# CORE INFRASTRUCUTRE SETTIGNS
    count = 1
    name = "virtual-machine-${count.index+1}"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.main.name}"
    network_interface_ids = ["${azurerm_network_interface.main[0].id}"]
    vm_size = "Standard_DS1_V2"
    delete_data_disks_on_termination = true

# WHICH OS THE VM WILL HAVE
    storage_image_reference {
        publisher = "Canonical"
        offer = "UbuntuServer"
        sku = "18.04-LTS"
        version = "latest"
    }

# MAIN STORAGE DISK
    storage_os_disk {
        name = "machine-disk-${count.index+1}"
        caching = "ReadWrite"
        create_option = "FromImage"
        managed_disk_type = "STANDARD_LRS"
    }

  storage_data_disk {
      name = "data-additional"
      lun = 1
      managed_disk_type = "Standard_LRS"
      create_option = "Empty"
      disk_size_gb = 10
  }

    storage_data_disk {
      name = "data-additional2"
      lun = 2
      managed_disk_type = "Standard_LRS"
      create_option = "Empty"
      disk_size_gb = 10
  }

    storage_data_disk {
      name = "${azurerm_managed_disk.disk.name}"
      lun = 3
      managed_disk_id = "${azurerm_managed_disk.disk.id}"
      create_option = "Attach"
      disk_size_gb = "${azurerm_managed_disk.disk.disk_size_gb}"
  }

# PROFILE OF THE VM - USER / PASSWORD
    os_profile {
        computer_name = "udemy"
        admin_username = "udemy"
        admin_password = "Password123!!"
    }

    os_profile_linux_config {
            disable_password_authentication = false
    }

# TAGS - KEY / VALUE PAIRS
    tags = {
            name = "virtual-machine-${count.index+1}"
            location = "${var.location}"
            resource_group_name = "${azurerm_resource_group.main.name}"
    }
}
