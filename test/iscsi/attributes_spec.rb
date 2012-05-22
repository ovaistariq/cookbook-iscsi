#
# Cookbook Name:: iscsi 
# Test:: attributes_spec 
#
# Author:: Eric G. Wolfe
#
# Copyright 2012, Eric G. Wolfe
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
require File.join(File.dirname(__FILE__), %w{.. support spec_helper})
require 'chef/node'
require 'chef/platform'

describe 'Iscsi::Attributes::Default' do
  let(:attr_ns) { 'iscsi' }

  before do
    @node = Chef::Node.new
    @node.consume_external_attrs(Mash.new(ohai_data), {})
    @node.from_file(File.join(File.dirname(__FILE__), %w{.. .. attributes default.rb}))
  end

  describe "for redhat 5 platform" do
    let(:ohai_data) do
      { :platform => "redhat", :platform_version => "5.7" }
    end

    it "must have a session.timeo.replacement_timeout between 15 and 120" do
      @node[attr_ns]['session']['timeo']['replacement_timeout'].must_be_close_to 15, 105
    end

    it "must have a conn0.timeo.noop_out_interval equal to 5" do
      @node[attr_ns]['conn0']['timeo']['noop_out_interval'].must_equal 5
    end

    it "must have a conn0.timeo.noop_out_timeout equal to 5" do
      @node[attr_ns]['conn0']['timeo']['noop_out_timeout'].must_equal 5
    end

    it "must have a session.initial_login_retry_max between 8 and 12" do
      @node[attr_ns]['session']['initial_login_retry_max'].must_be_close_to 12, 4
    end

    it "must have a session.cmds_max between 128 and 1024" do
      @node[attr_ns]['session']['cmds_max'].must_be_close_to 1024, 896
    end

    it "must have a session.queue_depth between 32 and 128" do
      @node[attr_ns]['session']['queue_depth'].must_be_close_to 128, 96
    end

    it "must have a package list equal to iscsi-initiator-utils" do
      @node[attr_ns]['packages'].must_equal %w{ iscsi-initiator-utils }
    end
  end
end
