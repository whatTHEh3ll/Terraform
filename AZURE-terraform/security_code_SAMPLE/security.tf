# TO ADD MORE SECURITY GROUPS COPY BLOCK AND INCREASE PRIORITY NUMBER
resource "azurerm_network_security_group" "security" {
    name = "mySecurityGroup"
    location            = "${azurerm_resource_group.main.location}"
    resource_group_name = "${azurerm_resource_group.main.name}"
    security_rule {
        name = "ssh"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_address_prefix = "*"
        source_port_range = "*"
        destination_address_prefix = "*"
        destination_port_ranges = ["22"]   # IMPORTANT RULE PORT
    }
}