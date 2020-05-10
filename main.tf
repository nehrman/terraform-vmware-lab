resource "packet_ssh_key" "vmware_lab" {
  name       = var.ssh_key_name
  public_key = file(var.ssh_public_key_file)
}

resource "packet_reserved_ip_block" "vmware_lab" {
  project_id = data.packet_project.vmware_lab.project_id
  facility   = var.facilities
  quantity   = var.ip_block_quantity
}

resource "packet_ip_attachment" "vmware_lab" {
  device_id     = packet_device.vmware_lab.id
  cidr_notation = join("/", [cidrhost(packet_reserved_ip_block.vmware_lab.cidr_notation, 0), "30"])
}

resource "packet_device" "vmware_lab" {
  depends_on       = [packet_ssh_key.vmware_lab]
  hostname         = var.host_name
  plan             = var.plan
  facilities       = [var.facilities]
  operating_system = var.os
  billing_cycle    = var.billing_cycle
  project_id       = data.packet_project.vmware_lab.project_id
}