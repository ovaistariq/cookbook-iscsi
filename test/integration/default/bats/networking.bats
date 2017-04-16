#!/usr/bin/env bats

@test "Check that ifconfig returns the correct inet addr" {
    /sbin/ifconfig eth0:1 | grep -F 'inet addr:192.168.33.100'
}

@test "Check that ifconfig returns the correct net mask" {
    /sbin/ifconfig eth0:1 | grep -Fw 'Mask:255.255.255.0'
}

@test "Check that the interface configuration is persistent" {
    grep -F 'DEVICE=eth0:1' '/etc/sysconfig/network-scripts/ifcfg-eth0:1'
    grep -F 'IPADDR=192.168.33.100' '/etc/sysconfig/network-scripts/ifcfg-eth0:1'
    grep -F 'NETMASK=255.255.255.0' '/etc/sysconfig/network-scripts/ifcfg-eth0:1'
    grep -F 'ONBOOT=yes' '/etc/sysconfig/network-scripts/ifcfg-eth0:1'
    grep -F 'BOOTPROTO=static' '/etc/sysconfig/network-scripts/ifcfg-eth0:1'
    grep -F 'MTU=9000' '/etc/sysconfig/network-scripts/ifcfg-eth0:1'
    grep -F 'HWADDR=90:E2:BA:5B:3F:44' '/etc/sysconfig/network-scripts/ifcfg-eth0:1'
}