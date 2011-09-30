#
# Cookbook Name:: iscsi
# Recipe:: default
#
# Copyright 2010, Gerald L. Hevener, Jr, M.S.
# Copyright 2010, Erig G. Wolfe
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node["iscsi"]["packages"].each do |iscsi_package|
  package iscsi_package
end

template "/etc/iscsi/iscsid.conf" do
  source "iscsid.conf.erb"
  mode "0600"
  owner "root"
  group "root"
end

execute "udevcontrol_reload_rules" do
  command "udevcontrol reload_rules"
  action :nothing
end

template "/etc/udev/rules.d/50-ethtool.rules" do
  source "50-ethtool.rules.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :run, "execute[udevcontrol_reload_rules]"
end

service "iscsid" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

service "iscsi" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

service "netfs" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

include_recipe "el-sysctl"
