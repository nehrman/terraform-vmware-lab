output "cidr_notation" {
    value = packet_reserved_ip_block.vmware_lab.cidr_notation
}

output "network" {
    value = packet_reserved_ip_block.vmware_lab.network
}

output "cidr" {
    value = packet_reserved_ip_block.vmware_lab.cidr
}

output "access_public_ipv4" {
    value = packet_device.vmware_lab.access_public_ipv4
}

output "root_password" {
    value = packet_device.vmware_lab.root_password
}