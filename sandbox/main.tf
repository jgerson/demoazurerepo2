provider "azurerm" {
}

resource "azurerm_resource_group" "rg" {

    count = 0

    name = "terraformdeploy-rg"

    location = "eastus"

}



resource "azurerm_network_interface" "terraform-nic1" {

    count = 0

    name = "terraform-nic1"

    location = "East US"

    resource_group_name = "${azurerm_resource_group.rg.name}"

    ip_configuration {

        name                          = "ipconfig1"

        subnet_id                     = "[redacted]"

        private_ip_address_allocation = "dynamic"

    }

}



resource "azurerm_virtual_machine" "testvmtf" {

    count = 0

    name = "testvmtf"

    location = "East US"

    resource_group_name = "${azurerm_resource_group.rg.name}"

    network_interface_ids = ["${azurerm_network_interface.terraform-nic1.id}"]

    vm_size = "Standard_DS1_v2"



    storage_os_disk {

        name              = "testvmosdisk"

        caching           = "ReadWrite"

        create_option     = "FromImage"

        managed_disk_type = "Standard_LRS"

    }



    storage_image_reference {

        publisher = "MicrosoftWindowsServer"

        offer     = "WindowsServer"

        sku       = "2016-Datacenter-Server-Core"

        version   = "latest"

    }



    os_profile {

        computer_name  = "testvmtf"

        admin_username = "azureuser"

        admin_password = "yourmom"

    }



    os_profile_windows_config {

        enable_automatic_upgrades = false

    }

}