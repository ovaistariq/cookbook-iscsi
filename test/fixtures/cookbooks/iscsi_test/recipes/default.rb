# Set test interfaces
node.set["iscsi"]["network_interfaces"] = {
  "eth0:1" => {
    "ipaddr" => "192.168.33.100",
    "netmask" => "255.255.255.0",
    "hwaddr" => "90:E2:BA:5B:3F:44"
  }
}

include_recipe "iscsi::default"