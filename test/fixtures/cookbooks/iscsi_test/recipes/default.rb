# Set test interfaces
node.set["iscsi"]["network_interfaces"] = {
  "eth0:1" => {
    "ipaddr" => "192.168.33.100",
    "netmask" => "255.255.255.0"
  }
}

include_recipe "iscsi::default"