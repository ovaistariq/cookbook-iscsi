maintainer       "Eric G. Wolfe"
maintainer_email "wolfe21@marshall.edu"
license          "Apache 2.0"
description      "Installs/Configures iscsi"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.4"
depends          "multipath"
depends          "el-sysctl"
recommends       "dbench"
conflicts        "sysctl"

# Attributes for this recipe.
attribute "iscsi/session/timeo/replacement_timeout",
  :display_name => "iscsi/session/timeo/replacement_timeout",
  :description => "Length of time to wait for session re-establishment before failing SCSI commands back to application.",
  :default => "15"

attribute "iscsi/conn0/timeo/noop_out_interval",
  :display_name => "iscsi/conn0/timeo/noop_out_interval",
  :description => "Time interval to wait before sending a ping.",
  :default => "5"

attribute "iscsi/conn0/timeo/noop_out_timeout",
  :display_name => "iscsi/conn0/timeo/noop_out_timeout",
  :description => "Time to wait for a Nop-out response before failing the connection.",
  :default => "5"

attribute "iscsi/session/initial_login_retry_max",
  :display_name => "iscsi/session/initial_login_retry_max",
  :description => "This only affects the initial login.",
  :default => "12"

attribute "iscsi/session/cmds_max",
  :display_name => "iscsi/session/cmds_max",
  :description => "Control how many commands the session will queue",
  :default => "1024"

attribute "iscsi/session/queue_depth",
  :display_name => "iscsi/session/queue_depth",
  :description => "Control the device's queue depth",
  :default => "128"

attribute "iscsi/session/iscsi/fastabort",
  :display_name => "iscsi/session/iscsi/fastabort",
  :description => "This is target specific, set to Yes for IET, No for Equallogic",
  :default => "No"

# Attributes for sysctl recipe
attribute "net/ipv4/conf/all/arp_ignore",
  :display_name => "net/ipv4/conf/all/arp_ignore",
  :description => "Workaround for ARP behavior with multiple interfaces on one subnet.",
  :default => "1"

attribute "net/ipv4/conf/all/arp_announce",
  :display_name => "net/ipv4/conf/all/arp_announce",
  :description => "Workaround for ARP behavior with multiple interfaces on one subnet.",
  :default => "2"

attribute "net/ipv4/netfilter/ip_conntrack_tcp_be_liberal",
  :display_name => "net/ipv4/netfilter/ip_conntrack_tcp_be_liberal",
  :description => "Workaround for packets being mareked invalid under heavy load on iSCSI.",
  :default => "1"

attribute "sysctl/has_iscsi",
  :display_name => "sysctl/has_iscsi",
  :description => "Boolean switch used in el-sysctl recipe template for iSCSI tweaks",
  :default => "false"
