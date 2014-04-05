#
# Cookbook Name:: iscsi
# Attributes:: default
#
# Copyright 2010, Gerald L. Hevener Jr, M.S.
# Copyright 2010, Eric G. Wolfe
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# RHEL default = 120, Recommendation = 15
# Source: https://access.redhat.com/kb/docs/DOC-2877
default['iscsi']['session']['timeo']['replacement_timeout'] = 15

default['iscsi']['conn0']['timeo']['noop_out_interval'] = 5
default['iscsi']['conn0']['timeo']['noop_out_timeout'] = 5

if node['platform_version'].to_i >= 6
  default['iscsi']['udev']['reload_command'] = 'udevadm control --reload-rules'
else
  default['iscsi']['udev']['reload_command'] = 'udevcontrol reload_rules'
end

# RHEL default = 8, Recommendation = 12
# Source: http://support.dell.com/support/edocs/software/rhel_mn/rhel5_4/iig_en.pdf
default['iscsi']['session']['initial_login_retry_max'] = 12

# RHEL default = 128, Recommendation = 1024
# Source: http://www.equallogic.com/resourcecenter/assetview.aspx?id=8727
default['iscsi']['session']['cmds_max'] = 1024

# RHEL default = 32, Recommendation = 128
# Source: http://www.equallogic.com/resourcecenter/assetview.aspx?id=8727
default['iscsi']['session']['queue_depth'] = 128

# Set to Yes, if using a BSD-based iSCSI Enterprise Target (IET)
# Set to No, for Equallogic arrays
default['iscsi']['session']['iscsi']['fastabort'] = 'Yes'

# Following attributes only apply to sysctl recipe
include_attribute 'sysctl'
default['sysctl']['params']['net']['ipv4']['conf']['all']['arp_ignore'] = 1
default['sysctl']['params']['net']['ipv4']['conf']['all']['arp_announce'] = 2
default['sysctl']['params']['net']['ipv4']['netfilter']['ip_conntrack_tcp_be_liberal'] = 1 if node['platform_version'].to_i == 5

# Following attributes apply to 50-ethtool.rules template
default['iscsi']['udev']['interfaces'] = []
default['iscsi']['udev']['ethtool_opts'] = ['-A %k autoneg off rx on tx on', '-K %k gro off']

# Following attributes are default set of packages to install
default['iscsi']['packages'] = %w(iscsi-initiator-utils)
