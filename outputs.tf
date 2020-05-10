output "cidr_notation" {
    value = packet_reserved_ip_block.vmware_lab_2.cidr_notation
}

output "network" {
    value = packet_reserved_ip_block.vmware_lab_2.network
}

output "cidr" {
    value = packet_reserved_ip_block.vmware_lab_2.cidr
}

output "access_public_ipv4" {
    value = packet_device.vmware_lab_2.access_public_ipv4
}

output "root_password" {
    value = packet_device.vmware_lab_2.root_password
}