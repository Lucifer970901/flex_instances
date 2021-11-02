
#declare the resources for linux instance
resource "oci_core_instance" "linux" {
  count               = "1"
 availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
 compartment_id      = "${var.compartment_ocid}"
  display_name        = "${var.instance_name}"
  shape               = "${var.shape}"

  create_vnic_details {
    assign_public_ip = "${var.assign_public_ip}"
    display_name   = "primaryvnic"
    hostname_label = "linuxInstance"
    subnet_id      = "${oci_core_subnet.publicsubnet.id}"
  }
  shape_config {
    ocpus = "${var.instance_ocpus}"
    memory_in_gbs = "${var.instance_shape_config_memory_in_gbs}"
  }

  metadata = {
     ssh_authorized_keys =  "${var.ssh_authorized_keys}"
    # ssh_authorized_keys = "${file("${var.ssh_authorized_keys}")}"
	#"${tls_private_key.public_private_key_pair.public_key_openssh}"
  }

  source_details {
    boot_volume_size_in_gbs = "${var.boot_volume_size_in_gbs}"
    source_id               = "${var.instance_image_ocid[var.region]}"
    source_type             = "image"
  }
  timeouts {
    create = "60m"
  }
}

resource "oci_core_volume" "linux" {
availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  compartment_id      ="${var.compartment_ocid}"
  display_name        = "Terraform_deployed_Instance"
  size_in_gbs         = "${var.boot_volume_size_in_gbs}"
}

resource "oci_core_volume_attachment" "linux" {
  count           = "1"
  attachment_type = "iscsi"
  compartment_id  = "${var.compartment_ocid}"
#  instance_id     = "${oci_core_instance.linux[count.index].id}"
  instance_id     = "${oci_core_instance.linux.*.id[count.index]}"
  volume_id       = "${oci_core_volume.linux.id}"
  use_chap        = true
}
