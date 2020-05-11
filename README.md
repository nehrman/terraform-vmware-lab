# terraform-vmware-lab

***Work in progress***

### What you need on your laptop (Mac OS X):
- Powershell Core
- PowerCLI 6.5 
- Terraform (Of Course)

### What you need to put in files folder: 
- Nested ESXi 6.7 OVA : https://download3.vmware.com/software/vmw-tools/nested-esxi/Nested_ESXi6.7_Appliance_Template_v1.ova
Beware, if you don't want to have an issue with import-vapp when importing Nested ESXi, you have to extract OVA file in Files folder and configure it in the scripts.
- VCSA ISO extracted in Files 
- NSX OVA if needed