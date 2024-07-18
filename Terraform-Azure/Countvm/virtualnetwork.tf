# 2 Resource create virtual network 
resource "azurerm_virtual_network" "tf-vnet" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.tf-rg.location
  resource_group_name = azurerm_resource_group.tf-rg.name
  address_space       = var.virtual_network_address_space

  depends_on = [ azurerm_resource_group.tf-rg ]
}

# 3  resource create subnet

resource "azurerm_subnet" "tf-subnet" {
  name                 = var.subnet_name
  virtual_network_name = azurerm_virtual_network.tf-vnet.name
  resource_group_name  = azurerm_resource_group.tf-rg.name
  address_prefixes     = [var.subnet_address_space]

depends_on = [azurerm_virtual_network.tf-vnet, azurerm_resource_group.tf-rg  ]
}

# 4  resource create public ip

resource "azurerm_public_ip" "tf-pip" {
  count = var.vm_count
  name                = "vm-pip-${count.index}"
  allocation_method   = "Static"
  location            = azurerm_resource_group.tf-rg.location
  resource_group_name = azurerm_resource_group.tf-rg.name


}


# 5 resource create network interface

resource "azurerm_network_interface" "tf-nic" {
  count = var.vm_count
  name                = "Terraform-nic-${count.index}"
  location            = azurerm_resource_group.tf-rg.location
  resource_group_name = azurerm_resource_group.tf-rg.name



  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.tf-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tf-pip[count.index].id
  }

depends_on = [ azurerm_resource_group.tf-rg, azurerm_virtual_network.tf-vnet ]

}

# 6 resource create nsg 


resource "azurerm_network_security_group" "tf-nsg" {
  name                = "Tf-nsg"
  location            = azurerm_resource_group.tf-rg.location
  resource_group_name = azurerm_resource_group.tf-rg.name

  security_rule {
    name                       = "allowed-allnetwork"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

depends_on = [ azurerm_resource_group.tf-rg,
azurerm_virtual_network.tf-vnet ]
  tags = {
    environment = "Production"
  }

}

