resource "packet_ssh_key" "vmware_lab" {
  name       = var.ssh_key_name
  public_key = file(var.ssh_public_key_file)
}

resource "packet_reserved_ip_block" "vmware_lab" {
  project_id = data.packet_project.vmware_lab.project_id
  facility   = var.facilities
  quantity   = var.ip_block_quantity
}

resource "packet_device" "vmware_lab" {
  depends_on       = [packet_ssh_key.vmware_lab]
  hostname         = var.host_name
  plan             = var.plan
  facilities       = [var.facilities]
  operating_system = var.os
  billing_cycle    = var.billing_cycle
  project_id       = data.packet_project.vmware_lab.project_id

  ip_address  {
      type = "private_ipv4"
      cidr = 29
  }

  ip_address {
      type = "public_ipv4"
      cidr = 29
      reservation_ids = [packet_reserved_ip_block.vmware_lab.id]
  }
}

resource "local_file" "script_pwsh" {

  content  = templatefile("${path.module}/Templates/vsphere-6.7-vghetto-standard-lab-deployment.tpl", {
      viserver = packet_device.vmware_lab.access_public_ipv4
      viserver_username = "root"
      viserver_password = packet_device.vmware_lab.root_password
      deployment_target = var.deployment_target
      gateway_ip_addr = cidrhost(packet_reserved_ip_block.vmware_lab.cidr_notation, 1)
      vcsa_ip_addr = cidrhost(packet_reserved_ip_block.vmware_lab.cidr_notation, 3)
      vcsa_host_name = var.vcsa_host_name
      vm_domain_name = var.vm_domain_name
      vc_datacenter_name = var.vc_datacenter_name
      vc_vsan_cluster_name = var.vc_vsan_cluster_name
      esx = zipmap(var.esx_names, [cidrhost(packet_reserved_ip_block.vmware_lab.cidr_notation, 4), cidrhost(packet_reserved_ip_block.vmware_lab.cidr_notation, 5), cidrhost(packet_reserved_ip_block.vmware_lab.cidr_notation, 6)])
  })
  filename = "${path.module}/Scripts/vsphere-6.7-vghetto-standard-lab-deployment.ps1"

  provisioner "local-exec"  {
      command = "./Scripts/vsphere-6.7-vghetto-standard-lab-deployment.ps1"
      interpreter = ["pwsh"]
  }
}




