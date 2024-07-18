/*
output "VM-IP" {
  description = "The VM Public IP is:"
  value       = azurerm_public_ip.tf-pip[count.index].ip_address
} 

*/

output "VM-IP" {
  description = "The VM Public IPs are:"
  value       = [for i in azurerm_public_ip.tf-pip : i.ip_address]  # Loop through all public IPs
}
