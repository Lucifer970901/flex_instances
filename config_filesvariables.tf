#define oci provider configuaration
provider "oci"{
#    tenancy_ocid = "${var.tenancy_ocid}"
#    user_ocid = "${var.user_ocid}"
    region ="${var.region}"
#    private_key_path = "${var.private_key_path}"
#   fingerprint = "${var.fingerprint}"
}

#provide the list of availability domain
data "oci_identity_availability_domains" "ADs" {
  compartment_id = "${var.compartment_ocid}"
#  ad_number = "${var.availability_domain}"
}
#common variables
#variable "tenancy_ocid"{}
#variable "user_ocid"{}
#variable "private_key_path"{}
#variable "fingerprint"{}
variable "region"{}
variable "compartment_ocid"{}

#variables to define vcn
variable "vcn_cidr_block"{
description = "provide the valid IPV4 cidr block for vcn"
default = "10.0.0.0/16"
}
variable "vcn_dns_label" {
  description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet. "
  default     = "vcn"
}
variable "vcn_display_name"{
description = "provide a display name for the vcn"
default= "demo_VCN"
}


#variables to define the public subnet
variable "cidr_block_publicsubnet"{
description = "note that the cidr block for the subnet must be smaller and part of the vcn cidr block"
default="10.0.0.0/24"
}

variable "publicSubnet_dns_label" {
description = "A DNS label prefix for the subnet, used in conjunction with the VNIC's hostname and VCN's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet. "
  default     = "publicsubnet"
}
variable "display_name_publicsubnet"{
description = "privide a displayname for public subnet"
default = "publicsubnet"
}

#variables to define private subnet
variable "display_name_privatesubnet"{
description = "privide a displayname for private subnet"
default = "privatesubnet"
}

variable "cidr_block_privatesubnet"{
description = "note that the cidr block for the subnet must be smaller and part of the vcn cidr block"
default="10.0.1.0/24"
}

variable "privateSubnet_dns_label" {
  description = "A DNS label prefix for the subnet, used in conjunction with the VNIC's hostname and VCN's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet. "
  default     = "privatesubnet"
}

#variables to create linux instance
variable "instance_image_ocid" {
#default ="ocid1.image.oc1.phx.aaaaaaaaug5utxnk3fj3lreoj26xxf3b27ngh4ves7i5xpzi7ezbuif47i4q"
  type = map(string)
  default = {
  us-phoenix-1 = "ocid1.image.oc1.phx.aaaaaaaa6hooptnlbfwr5lwemqjbu3uqidntrlhnt45yihfj222zahe7p3wq"
  us-ashburn-1 = "ocid1.image.oc1.iad.aaaaaaaa6tp7lhyrcokdtf7vrbmxyp2pctgg4uxvt4jz4vc47qoc2ec4anha"
  eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaadvi77prh3vjijhwe5xbd6kjg3n5ndxjcpod6om6qaiqeu3csof7a"
  uk-london-1 = "ocid1.image.oc1.uk-london-1.aaaaaaaaw5gvriwzjhzt2tnylrfnpanz5ndztyrv3zpwhlzxdbkqsjfkwxaq"
  }
}
variable "shape" {
  default = "VM.Standard.E3.Flex"
}
variable "instance_ocpus" {
  default = 1
}

variable "instance_shape_config_memory_in_gbs" {
  default = 1
}
variable "instance_name"{
description  = "provide the display name for the linux instance to be deployed"
}

#variable "ssh_public_key" {
#  default = "C:\Terraform\oci_key_public.pem"
#}

variable "preserve_boot_volume" {
  default = false
}

variable "ssh_authorized_keys" {
description = "Provide SSH public key"
}
variable "boot_volume_size_in_gbs" {
  default = "50"
}
variable "assign_public_ip" {
  default = true
}
