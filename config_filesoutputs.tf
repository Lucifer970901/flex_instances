#this file contains the output from resources deployed


#output from linux instance.
output "instance_id"{
value = "${oci_core_instance.linux.*.id}"
}

output "assigned_public_ip" {
 description = "Public IPs of created instances. "
 value       = "${oci_core_instance.linux.*.public_ip}"

}

#output "ssh-key" {
#    value = ["${tls_private_key.public_private_key_pair.public_key_openssh}"]
#}

#output "ssh-public-key_in_openssh_format" {
#    value = ["${tls_private_key.public_private_key_pair.public_key_openssh}"]
#}
#output "ssh-private-key_pem" {
#value = ["${tls_private_key.public_private_key_pair.private_key_pem}"]
#}
#output "ssh-public-key_pem" {
#value = ["${tls_private_key.public_private_key_pair.public_key_pem}"]
#}
