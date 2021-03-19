terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
    }
    packet = {
      source = "packethost/packet"
    }
    vsphere = {
      source = "hashicorp/vsphere"
    }
  }
  required_version = ">= 0.13"
}
