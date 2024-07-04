######################
# Network Security Group(s) - NSGs
######################

# resource definitions
resource "oci_core_network_security_group" "main" {
  compartment_id = local.compartment_id
  vcn_id         = local.vcn_id
  display_name   = var.display_name
  defined_tags   = var.defined_tags
  freeform_tags  = local.merged_freeform_tags
}

######################
# Network Security Group Rules
######################

# resource definitions
# ingress
resource "oci_core_network_security_group_security_rule" "ingress_rules" {
  count = length(var.rules.ingress_rules)

  network_security_group_id = oci_core_network_security_group.main.id
  direction                 = "INGRESS"
  protocol                  = var.rules.ingress_rules[count.index].protocol
  description               = var.rules.ingress_rules[count.index].description
  source                    = var.rules.ingress_rules[count.index].src
  source_type               = var.rules.ingress_rules[count.index].src_type
  stateless                 = var.rules.ingress_rules[count.index].stateless
  dynamic "tcp_options" {
    for_each = var.rules.ingress_rules[count.index].protocol == "6" ? { "tcp_options" = var.rules.ingress_rules[count.index] } : {}

    content {
      #Optional
      dynamic "destination_port_range" {
        for_each = tcp_options.value["dst_port"] != null ? { "dst_port" = tcp_options.value["dst_port"] } : {}

        content {
          #Required
          max = destination_port_range.value["max"]
          min = destination_port_range.value["min"]
        }
      }
      dynamic "source_port_range" {
        for_each = tcp_options.value["src_port"] != null ? { "src_port" = tcp_options.value["src_port"] } : {}

        content {
          #Required
          max = source_port_range.value["max"]
          min = source_port_range.value["min"]
        }
      }
    }
  }
  dynamic "udp_options" {
    for_each = var.rules.ingress_rules[count.index].protocol == "17" ? { "udp_options" = var.rules.ingress_rules[count.index] } : {}

    content {
      #Optional
      dynamic "destination_port_range" {
        for_each = udp_options.value["dst_port"] != null ? { "dst_port" = udp_options.value["dst_port"] } : {}

        content {
          #Required
          max = destination_port_range.value["max"]
          min = destination_port_range.value["min"]
        }
      }
      dynamic "source_port_range" {
        for_each = udp_options.value["src_port"] != null ? { "src_port" = udp_options.value["src_port"] } : {}

        content {
          #Required
          max = source_port_range.value["max"]
          min = source_port_range.value["min"]
        }
      }
    }
  }
}

# egress
resource "oci_core_network_security_group_security_rule" "egress_rules" {
  count = length(var.rules.egress_rules)

  network_security_group_id = oci_core_network_security_group.main.id
  direction                 = "EGRESS"
  protocol                  = var.rules.egress_rules[count.index].protocol
  description               = var.rules.egress_rules[count.index].description
  destination               = var.rules.egress_rules[count.index].dst
  destination_type          = var.rules.egress_rules[count.index].dst_type
  stateless                 = var.rules.egress_rules[count.index].stateless
  dynamic "tcp_options" {
    for_each = var.rules.egress_rules[count.index].protocol == "6" ? { "tcp_options" = var.rules.egress_rules[count.index] } : {}

    content {
      #Optional
      dynamic "destination_port_range" {
        for_each = tcp_options.value["dst_port"] != null ? { "dst_port" = tcp_options.value["dst_port"] } : {}

        content {
          #Required
          max = destination_port_range.value["max"]
          min = destination_port_range.value["min"]
        }
      }
      dynamic "source_port_range" {
        for_each = tcp_options.value["src_port"] != null ? { "src_port" = tcp_options.value["src_port"] } : {}

        content {
          #Required
          max = source_port_range.value["max"]
          min = source_port_range.value["min"]
        }
      }
    }
  }
  dynamic "udp_options" {
    for_each = var.rules.egress_rules[count.index].protocol == "17" ? { "udp_options" = var.rules.egress_rules[count.index] } : {}

    content {
      #Optional
      dynamic "destination_port_range" {
        for_each = udp_options.value["dst_port"] != null ? { "dst_port" = udp_options.value["dst_port"] } : {}

        content {
          #Required
          max = destination_port_range.value["max"]
          min = destination_port_range.value["min"]
        }
      }
      dynamic "source_port_range" {
        for_each = udp_options.value["src_port"] != null ? { "src_port" = udp_options.value["src_port"] } : {}

        content {
          #Required
          max = source_port_range.value["max"]
          min = source_port_range.value["min"]
        }
      }
    }
  }
}