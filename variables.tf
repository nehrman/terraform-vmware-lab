###########################################################
#                                                         #
#     Variables for configuring Packet Deployment         #
#                                                         #
###########################################################

variable "project_name" {
  description = "Defines the Project Name in Packet"
  type        = string
  default     = "MYVWorld"
}

variable "host_name" {
  description = "Defines the Host Name of the deployed Host"
  type        = string
  default     = "esximaster"
}

variable "plan" {
  description = "Defines Packet Plan"
  type        = string
  default     = "c1.small.x86"
}

variable "facilities" {
  description = "Defines the facilities where to deploy in Packet"
  type        = string
  default     = "ams1"
}

variable "os" {
  description = "Defines the type of OS to deploy"
  type        = string
  default     = "vmware_esxi_6_5"
}

variable "billing_cycle" {
  description = "Defines the billing cycle. Monthly or Hourly values are accepted"
  type        = string
  default     = "hourly"
}

variable "ip_block_quantity" {
  description = "Defines the number of allocated /32 addresses"
  type        = number
  default     = 16
}

variable "ssh_key_name" {
  description = "Defines the name of the SSH Key used by the host"
  type        = string
  default     = "vmware_lab"
}

variable "ssh_public_key_file" {
  description = "Defines the file used for public ssh key"
  type        = string
  default     = "id_rsa_az.pub"
}

###########################################################
#                                                         #
#     Variables for configuring Homelab Deployment        #
#                                                         #
###########################################################

variable "deployment_target" {
  description = "Defines the target for the deployment. Value could be ESXI, VCENTER or VMC."
  type        = string
  default     = "ESXI"
}

variable "esx_names" {
  description = "Defines the list of ESXi names used in the deployment."
  type        = list
  default = [
    "esx01",
    "esx02",
    "esx03"
  ]
}

variable "vcsa_host_name" {
  description = "Defines the hostname (short) of the VCSA appliance."
  type        = string
  default     = "vcsa"
}

variable "vm_domain_name" {
  description = "Defines the name of the domain (for FQDN and Domain search)."
  type        = string
  default     = "my-v-world.fr"
}

variable "vc_datacenter_name" {
  description = "Defines the name of the Datacenter in VCSA Appliance."
  type        = string
  default     = "MYVWORLD"
}

variable "vc_vsan_cluster_name" {
  description = "Defines the name of the ESXi / VSAN cluster in VCSA Appliance."
  type        = string
  default     = "VSANCLUSTER01"
}

variable "esxivCPU" {
  description = "Defines the number of vCPU per ESXi"
  type        = string
  default     = "4"
}

variable "esxivMEM" {
  description = "Defines the size of vMEM per ESXi"
  type        = string
  default     = "8"
}

variable "esxicachingvdisk" {
  description = "Defines the size of Cahcing Disk per ESXi"
  type        = string
  default     = "20"
}

variable "esxicapavdisk" {
  description = "Defines the size of Capacity Disk per ESXi"
  type        = string
  default     = "40"
}

variable "vcsassopassword" {
  description = "Defines password uses for VCSA SSO"
  type        = string
  default     = "G9kEQ7=T]e|w^-[We"
}

variable "vcsarootpassword" {
  description = "Defines password uses for VCSA root access"
  type        = string
  default     = "G9kEQ7=T]e|w^-[We"
}

variable "vcsasshenable" {
  description = "Defines if ssh access on VCSA is authorized or not"
  type        = string
  default     = "false"
}

variable "vmpassword" {
  description = "Defines password uses for ESXI root access"
  type        = string
  default     = "G9kEQ7=T]e|w^-[We"
}

variable "vmsshenable" {
  description = "Defines if ssh access on ESXi is authorized or not"
  type        = string
  default     = "false"
}

variable "deploynsx" {
  description = "Defines if NSX should be deploy or  not"
  type        = number
  default     = 0
}

variable "virtual_switch_type" {
  description = "Defines the Virtual Switch Type. Allowed : VSS or VDS"
  type        = string
  default     = "VSS"
}

variable "vm_network" {
  description = "Defines the Virtual Network Name"
  type        = string
  default     = "VM Network"
}


