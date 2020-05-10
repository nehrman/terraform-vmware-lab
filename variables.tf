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
  default     = "c3.small.x86"
}

variable "facilities" {
  description = "Defines the facilities where to deploy in Packet"
  type        = string
  default     = "ams1"
}

variable "os" {
  description = "Defines the type od OS to deploy"
  type        = string
  default     = "vmware_esxi_6_7"
}

variable "billing_cycle" {
  description = "Defines the billing cycle. Monthly or Hourly values are accepted"
  type        = string
  default     = "hourly"
}

variable "ip_block_quantity" {
  description = "Defines the number of allocated /32 addresses"
  type        = number
  default     = 8
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