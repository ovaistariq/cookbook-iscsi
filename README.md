iSCSI Cookbook
--------------

[![Build Status](https://secure.travis-ci.org/atomic-penguin/cookbook-iscsi.png?branch=master)](http://travis-ci.org/atomic-penguin/cookbook-iscsi)

Description
===========

  This cookbook provides the ability to configure Open-iSCSI for
Enterprise Linux based systems.  The default attributes reflect original
research and recommendations gathered from Dell, Equallogic, and RedHat.

  Here is a [link](http://atomic-penguin.github.io/blog/2010/11/29/Red-Hat-Enterprise-Linux-5.x-iSCSI-and-device-mapper-multipath-HOWTO)
to my own whitepaper in blog form, discussing the configuration and tuning of Open-iSCSI
with this cookbook, as supplementary documentation.  Here is a list of recommended
source documentation in addition to the linked blog post.

  * [Red Hat KB 2877](https://access.redhat.com/kb/docs/DOC-2877)
  * ~~Dell PowerEdge Systems Red Hat Enterprise Linux 5.4 Install Notes~~ (dead link)
  * ~~Red Hat Linux v5.x Software iSCSI Initiator Configuration and tuning Guide~~ (dead link)
  * [Open-iSCSI documentation](http://www.open-iscsi.org/index.html#docs)


Requirements
============

### Required Cookbooks

  * multipath 
  * sysctl

### Recommended Cookbooks

  * dbench

Attributes
==========

### iscsid.conf

  * iscsi (namespace)
    - `['session']['timeo']['replacement_timeout']` Time to wait before failing SCSI commands back to the application, default 15
    - `['conn0']['timeo']['noop_out_interval']` Interval to wait before sending a ping, default 5
    - `['conn0']['timeo']['noop_out_timeout']` Time to wait for a NOP-out before failing the connection, default 5
    - `['session']['initial_login_retry_max']` Initial number of login tries, default 12
    - `['session']['cmds_max']` How many commands the session will queue, default 1024
    - `['session']['queue_depth']` Device queue depth, default 128
    - `['session']['iscsi']['fastabort']` IET targets need Yes, Equallogic needs set to No. Default is Yes

### udev

  * iscsi.udev (namespace)
    - `['interfaces']` Array of ethernet devices to apply ethtool options via udev. Default empty.
    - `['ethtool_opts']` Turn on, or off, certain features on iSCSI ethernet devices.
        Default flow control on, autonegotiate off, Generic Recieve offload off.
    - `[reload_command']` platform version specific command to reload udev rules.

### sysctl.params

  * sysctl.params.net.ipv4 (namespace)
    - `['conf']['all']['arp_ignore']` Modes of ARP replies. Default 1, reply only if local IP address.
    - `['conf']['all']['arp_announce']` Modes of ARP announcement. Default 2, use the best lcoal address.
    - `['ipv4']['netfilter']['ip_conntrack_tcp_be_liberal']` 1 Disables TCP window tracking, default 1 on RHEL5.

## Usage

### Default recipe

  Set role specific overrides, and add recipe['iscsi'] to runlist

Example iSCSI role for an Equallogic storage array

```
name 'iscsi'
description 'Installs and configures Open-iSCSI for EQL. Installs dm-multipath.  Configures sysctl.'
override_attributes 'iscsi' => {
  'session' => {
    'iscsi' => {
      'fastabort' => 'No'
  }
},
run_list 'recipe[iscsi]', 'recipe[multipath]', 'recipe[dbench]'
```

Example iSCSI role for an IET storage array

```
name 'iscsi'
description 'Installs and configures Open-iSCSI for IET. Installs dm-multipath.  Configures sysctl.'
override_attributes 'iscsi' => {
  'session' => {
    'iscsi' => {
      'fastabort' => 'Yes'
  }
},
run_list 'recipe[iscsi]', 'recipe[multipath]', 'recipe[dbench]'
```

### rescan-scsi-bus recipe

Simply `include_recipe 'iscsi::rescan-scsi-bus'` to drop off Kurt Garloff's
handy rescan-scsi-bus script.  This has nothing to do with iSCSI, other than
it may come in handy to rescan the SCSI bus when you target a new LUN.

This recipe only drops off the script in /usr/local/bin, the recipe does not
execute anything.

## License and Author 

Copyright 2010-2012, Eric G. Wolfe

Licensed under the Apache License, Version 2.0 (the 'License');
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an 'AS IS' BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
