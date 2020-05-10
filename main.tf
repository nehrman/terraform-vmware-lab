resource "packet_ssh_key" "vmware_lab" {
  name       = var.ssh_key_name
  public_key = file(var.ssh_public_key_file)
}

resource "packet_reserved_ip_block" "vmware_lab" {
  project_id = data.packet_project.vmware_lab.project_id
  facility   = var.facilities
  quantity   = var.ip_block_quantity
}

#resource "packet_ip_attachment" "vmware_lab" {
#  device_id     = packet_device.vmware_lab.id
#  cidr_notation = join("/", [cidrhost(packet_reserved_ip_block.vmware_lab.cidr_notation, 0), "30"])
#}

resource "packet_device" "vmware_lab" {
  depends_on       = [packet_ssh_key.vmware_lab]
  hostname         = var.host_name
  plan             = var.plan
  facilities       = [var.facilities]
  operating_system = var.os
  billing_cycle    = var.billing_cycle
  project_id       = data.packet_project.vmware_lab.project_id
}

resource "packet_reserved_ip_block" "vmware_lab_2" {
  project_id = data.packet_project.vmware_lab.project_id
  facility   = var.facilities
  quantity   = var.ip_block_quantity
}

resource "packet_device" "vmware_lab_2" {
  depends_on       = [packet_ssh_key.vmware_lab]
  hostname         = "esximaster02"
  plan             = "c1.small.x86"
  facilities       = [var.facilities]
  operating_system = "vmware_esxi_6_5"
  billing_cycle    = var.billing_cycle
  project_id       = data.packet_project.vmware_lab.project_id

  ip_address  {
      type = "private_ipv4"
      cidr = 29
  }

  ip_address {
      type = "public_ipv4"
      cidr = 29
      reservation_ids = [packet_reserved_ip_block.vmware_lab_2.id]
  }
}

resource "local_file" "script_pwsh" {

  content  = templatefile("${path.module}/Templates/vsphere-6.7-vghetto-standard-lab-deployment.tpl", {
      viserver = packet_device.vmware_lab_2.access_public_ipv4
      viserver_username = "root"
      viserver_password = packet_device.vmware_lab_2.root_password
      deployment_target = var.deployment_target
      gateway_ip_addr = cidrhost(packet_reserved_ip_block.vmware_lab_2.cidr_notation, 1)
      vcsa_ip_addr = cidrhost(packet_reserved_ip_block.vmware_lab_2.cidr_notation, 3)
      vcsa_host_name = "vcsa"
      vm_domain_name = "my-v-world.fr"
      vc_datacenter_name = "MYVWORLD"
      vc_vsan_cluster_name = "VSANCLUSTER01"
      esx = zipmap(var.esx_names, [cidrhost(packet_reserved_ip_block.vmware_lab_2.cidr_notation, 4), cidrhost(packet_reserved_ip_block.vmware_lab_2.cidr_notation, 5), cidrhost(packet_reserved_ip_block.vmware_lab_2.cidr_notation, 6)])
  })
  filename = "${path.module}/Scripts/vsphere6.7.ps1"

  provisioner "local-exec"  {
      command = "./Scripts/vsphere6.7.ps1"
      interpreter = ["pwsh","-NonInteractive"]
  }
}




