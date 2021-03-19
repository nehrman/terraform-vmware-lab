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

  ip_address {
    type = "private_ipv4"
    cidr = 28
  }

  ip_address {
    type            = "public_ipv4"
    cidr            = 28
    reservation_ids = [packet_reserved_ip_block.vmware_lab.id]
  }
}

resource "null_resource" "waiting_vmware_lab" {
  depends_on = [packet_device.vmware_lab]

  triggers ={
    date = timestamp()
  }

  provisioner "local-exec" {
    command = "until $(sleep 60 && curl --output /dev/null --insecure --silent --max-time 5 --head --fail https://esximaster.my-v-world.fr/ui/ -v); do printf '.' && sleep 5; done"
  }
}


resource "local_file" "script_pwsh" {
  depends_on = [null_resource.waiting_vmware_lab]

  content = templatefile("${path.module}/Templates/vsphere-6.7-vghetto-standard-lab-deployment.tpl", {
    viserver             = packet_device.vmware_lab.access_public_ipv4
    viserver_username    = "root"
    viserver_password    = packet_device.vmware_lab.root_password
    deployment_target    = var.deployment_target
    esxivCPU             = var.esxivCPU
    esxivMEM             = var.esxivMEM
    esxicachingvdisk     = var.esxicachingvdisk
    esxicapavdisk        = var.esxicapavdisk 
    vcsassopassword      = var.vcsassopassword
    vcsarootpassword     = var.vcsarootpassword
    vcsasshenable        = var.vcsasshenable
    vmpassword           = var.vmpassword
    vmsshenable          = var.vmsshenable
    gateway_ip_addr      = cidrhost(packet_reserved_ip_block.vmware_lab.cidr_notation, 1)
    vcsa_ip_addr         = cidrhost(packet_reserved_ip_block.vmware_lab.cidr_notation, 3)
    vcsa_host_name       = var.vcsa_host_name
    vm_domain_name       = var.vm_domain_name
    vc_datacenter_name   = var.vc_datacenter_name
    vc_vsan_cluster_name = var.vc_vsan_cluster_name
    esx                  = zipmap(var.esx_names, [cidrhost(packet_reserved_ip_block.vmware_lab.cidr_notation, 4), cidrhost(packet_reserved_ip_block.vmware_lab.cidr_notation, 5), cidrhost(packet_reserved_ip_block.vmware_lab.cidr_notation, 6)])
    deploynsx            = var.deploynsx
    virtualswitchtype    = var.virtual_switch_type
    vmnetwork            = var.vm_network
  })
  filename = "${path.module}/Scripts/vsphere-6.7-vghetto-standard-lab-deployment.ps1"

  provisioner "local-exec" {
    command     = "./Scripts/vsphere-6.7-vghetto-standard-lab-deployment.ps1"
    interpreter = ["pwsh"]
  }

  lifecycle {
    ignore_changes = [content,filename]
  }
}

#resource "vsphere_file" "boundary" {

#}


