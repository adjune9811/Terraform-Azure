# Resource group variables

variable "resource_group_name" {
  description = "This is name of resource group"
  type        = string
  //  default = terraform-rg
}


# Resource group location variables

variable "resource_group_location" {
  description = "This is location of resource group"
  type        = string
  // default = eastus
}


variable "virtual_network_name" {
  description = "This is for virtual network"
  type        = string

}

variable "virtual_network_address_space" {
  description = "This is for virtual network address space"
  type        = list(string)

}

variable "subnet_name" {
  description = "This is for subnet name"
  type        = string

}


variable "subnet_address_space" {
  description = "This is for subnet address space"
  type        = string

}

variable "virtual_machine_name" {
  description = "This is name of the virutal machine"
  type        = string
  // default = eastus
}


variable "vm_count" {
  description = "This is name of the count meta arugment"
  type        = string
  // default = 4
}
