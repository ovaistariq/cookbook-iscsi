#!/usr/bin/env bats

# udevadm test autoneg
@test 'udevadm test reports autoneg off' {
  udevadm test /class/net/eth0 2>&1|egrep 'run.+-A.+autoneg off'
}

# udevadm test rx
@test 'udevadm test reports rx on' {
  udevadm test /class/net/eth0 2>&1|egrep 'run.+-A.+rx on'
}

# udevadm test rx
@test 'udevadm test reports rx on' {
  udevadm test /class/net/eth0 2>&1|egrep 'run.+-A.+rx on'
}

# udevadm test gro
@test 'udevadm test reports gro off' {
  udevadm test /class/net/eth0 2>&1|egrep 'run.+-K.+gro off'
}

# iscsi-initiator-utils installed
@test 'iscsi-initiator-utils installed' {
  rpm -q iscsi-initiator-utils
}

@test 'sysctl attributes appear to be correct' {
  egrep 'net.ipv4.conf.all.arp_ignore ?= ?1' /etc/sysctl.d/99-chef-attributes.conf &&
  egrep 'net.ipv4.conf.all.arp_announce ?= ?2' /etc/sysctl.d/99-chef-attributes.conf
}
