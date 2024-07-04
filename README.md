# OCI Network Security Group Terraform Module

This module provisions a Network Security Group (NSG) in Oracle Cloud Infrastructure (OCI).

## Variables

### `tenancy_ocid`

- **Description:** (Required) (Updatable) The OCID of the root compartment.
- **Type:** string
- **Default:** null

### `compartment_id`

- **Description:** The default compartment OCID to use for resources (unless otherwise specified).
- **Type:** string
- **Default:** null

### `compartment`

- **Description:** Compartment name where to create all resources.
- **Type:** string
- **Default:** null

### `vcn_id`

- **Description:** The VCN ID where the Security List(s) should be created.
- **Type:** string
- **Default:** null

### `vcn_name`

- **Description:** The VCN name where the Security List(s) should be created.
- **Type:** string
- **Default:** null

### `freeform_tags`

- **Description:** Simple key-value pairs to tag the resources created using freeform tags.
- **Type:** map(string)
- **Default:** null

### `defined_tags`

- **Description:** Predefined and scoped to a namespace to tag the resources created using defined tags.
- **Type:** map(string)
- **Default:** null

### `display_name`

- **Description:** (Optional) (Updatable) A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information.
- **Type:** string
- **Default:** null

### `rules`

- **Description:** Security rules for the NSG.
- **Type:** object
  - **`ingress_rules`**:
    - **description:** string
    - **stateless:** optional(bool, false)
    - **protocol:** optional(string, "6")
    - **src:** string
    - **src_type:** optional(string, "CIDR_BLOCK")
    - **src_port:** optional(object({min = number, max = number}), null)
    - **dst_port:** optional(object({min = number, max = number}), null)
    - **icmp_type:** optional(number, null)
    - **icmp_code:** optional(number, null)
  - **`egress_rules`**:
    - **description:** string
    - **stateless:** optional(bool, false)
    - **protocol:** optional(string, "6")
    - **dst:** string
    - **dst_type:** optional(string, "CIDR_BLOCK")
    - **src_port:** optional(object({min = number, max = number}), null)
    - **dst_port:** optional(object({min = number, max = number}), null)
    - **icmp_type:** optional(number, null)
    - **icmp_code:** optional(number, null)
- **Default:** null

