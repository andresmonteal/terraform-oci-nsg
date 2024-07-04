# default values
locals {
  #general defaults
  compartment_id = try(data.oci_identity_compartments.compartment[0].compartments[0].id, var.compartment_id)
  vcn_id         = try(data.oci_core_vcns.vcns[0].virtual_networks[0].id, var.vcn_id)
  default_freeform_tags = {
    terraformed = "Please do not edit manually"
    module      = "oracle-terraform-oci-nsg"
  }
  merged_freeform_tags = merge(local.default_freeform_tags, var.freeform_tags)
  nsg_id               = oci_core_network_security_group.main.id
}