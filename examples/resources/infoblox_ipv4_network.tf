# Statically allocated IPv4 network, minimal set of parameters
resource "infoblox_ipv4_network" "net1" {
  cidr = "10.0.0.0/16"
}

# Full set of parameters for statically allocated IPv4 network
resource "infoblox_ipv4_network" "net2" {
  cidr         = "10.1.0.0/24"
  network_view = "nondefault_netview"
  reserve_ip   = 5
  gateway      = "10.1.0.254"
  comment      = "small network for testing"
  ext_attrs = jsonencode({
    "Site" = "bla-bla-bla... testing..."
  })
}

# Full set of parameters for dynamically allocated IPv4 network
resource "infoblox_ipv4_network" "net3" {
  parent_cidr         = infoblox_ipv4_network_container.nc1.cidr # reference to the resource from another example
  allocate_prefix_len = 26                                       # 24 (existing network container) + 2 (new network), prefix
  network_view        = "default"                                # we may omit this but it is not a mistake to specify explicitly
  reserve_ip          = 2
  gateway             = "none" # no gateway defined for this network
  comment             = "even smaller network for testing"
  ext_attrs = jsonencode({
    "Site" = "any place you wish ..."
  })
}

# Dynamically allocated IPv4 network within a network using next-available
resource "infoblox_ipv4_network" "ipv4_network1" {
  object              = "network"
  allocate_prefix_len = 26
  comment             = "network created"
  filter_params = jsonencode({
    "*Site" = "Nainital"
  })
  ext_attrs = jsonencode({
    Location = "Badrinath"
  })
}

# Dynamically allocated IPv4 network within a networkcontainer using next-available
resource "infoblox_ipv4_network" "ipv4_network2" {
  object              = "networkcontainer"
  allocate_prefix_len = 26
  comment             = "network created"
  filter_params = jsonencode({
    "*Site" = "Nainital"
  })
  ext_attrs = jsonencode({
    Location = "Badrinath"
  })
}
