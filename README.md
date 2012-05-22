# iSCSI [![Build Status](https://secure.travis-ci.org/atomic-penguin/cookbook-iscsi.png?branch=master)](http://travis-ci.org/atomic-penguin/iscsi)

## Description

  This cookbook provides provides the ability to configure Open-iSCSI for
Enterprise Linux based systems.  The default attributes reflect original
research and recommendations gathered from Dell, Equallogic, and RedHat.

  I have included a PDF of our own whitepaper discussing the configuration
and tuning of Open-iSCSI with this cookbook, as supplementary documentation.
Here is a list of recommended source documentation in addition to the
included PDF.

  * [Red Hat KB 2877](https://access.redhat.com/kb/docs/DOC-2877)
  * [Dell PowerEdge Systems Red Hat Enterprise Linux 5.4 Install Notes](http://support.dell.com/support/edocs/software/rhel_mn/rhel5_4/iig_en.pdf)
  * [Red Hat Linux v5.x Software iSCSI Initiator Configuration and tuning Guide](http://www.equallogic.com/resourcecenter/assetview.aspx?id=8727)
  * [Open-iSCSI documentation](http://www.open-iscsi.org/index.html#docs)


## Requirements

### Required Cookbooks

  * multipath 
  * el-sysctl

### Recommended Cookbooks

  * dbench

## Attributes

### iscsid.conf

  * iscsi (namespace)
    - ["session"]["timeo"]["replacement\_timeout"]: Time to wait before failing SCSI commands back to the application, default 15
    - ["conn0"]["timeo"]["noop\_out\_interval"]: Interval to wait before sending a ping, default 5
    - ["conn0"]["timeo"]["noop\_out\_timeout"]: Time to wait for a NOP-out before failing the connection, default 5
    - ["session"]["initial\_login\_retry\_max"]: Initial number of login tries, default 12
    - ["session"]["cmds_max"]: How many commands the session will queue, default 1024
    - ["session"]["queue_depth"]: Device queue depth, default 128
    - ["session"]["iscsi"]["fastabort"]: IET targets need Yes, Equallogic needs set to No. Default is Yes

### udev rules

  * iscsi (namespace)
    - ["interfaces"] Array of ethernet devices to apply ethtool options via udev. Default empty.
    - ["ethtool\_opts"] Turn on or off, certain features on iSCSI ethernet devices.
        Default flow control on, autonegotiate off, Generic Recieve offload off

### sysctl

  * net (namespace)
    - ["ipv4"]["conf"]["all"]["arp_ignore"] Modes of ARP replies. Default 1, reply only if local IP address.
    - ["ipv4"]["conf"]["all"]["arp_announce"] Modes of ARP announcement. Default 2, use the best lcoal address.
    - ["ipv4"]["netfilter"]["ip\_conntrack\_tcp\_be\_liberal"] 1 Disables TCP window tracking, default 1

  * sysctl
    - ["has\_iscsi"] Boolean to turn on iSCSI elements in sysctl recipe template, Default false

## Usage

### Default recipe

  Set role specific overrides, and add recipe["iscsi"] to runlist

Example iSCSI role for an Equallogic storage array

```
name "iscsi"
description "Installs and configures Open-iSCSI for EQL. Installs dm-multipath.  Configures sysctl."
override_attributes "iscsi" => {
  "session" => {
    "iscsi" => {
      "fastabort" => "No"
  }
},
"sysctl" => {
  "has_iscsi" => true
}
run_list "recipe[iscsi]", "recipe[el-sysctl]", "recipe[multipath]", "recipe[dbench]"
```

Example iSCSI role for an IET storage array

```
name "iscsi"
description "Installs and configures Open-iSCSI for IET. Installs dm-multipath.  Configures sysctl."
override_attributes "iscsi" => {
  "session" => {
    "iscsi" => {
      "fastabort" => "Yes"
  }
},
"sysctl" => {
  "has_iscsi" => true
}
run_list "recipe[iscsi]", "recipe[el-sysctl]", "recipe[multipath]", "recipe[dbench]"
```

### rescan-scsi-bus recipe

Simply `include\_recipe "iscsi::rescan-scsi-bus"` to drop off Kurt Garloff's
handy rescan-scsi-bus script.  This has nothing to do with iSCSI, other than
it may come in handy to rescan the SCSI bus when you target a new LUN.

This recipe only drops off the script in /usr/local/bin, the recipe does not
execute anything.

## License and Author 

Copyright 2010-2012, Eric G. Wolfe

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
