require 'spec_helper'

describe 'iscsi::default' do
  context 'on Centos 6.5 x86_64' do
    let(:chef_run) do
      ChefSpec::Runner.new(platform: 'centos', version: 6.5) do |node|
      end.converge(described_recipe)
    end
    let(:udev_template) { chef_run.template('/etc/udev/rules.d/50-ethtool.rules') }
    let(:iscsi_template) { chef_run.template('/etc/iscsi/iscsid.conf') }

    it 'includes recipe sysctl' do
      expect(chef_run).to include_recipe('sysctl')
    end

    it 'installs iscsi-initiator-utils' do
      expect(chef_run).to install_package('iscsi-initiator-utils')
    end

    it 'renders iscsid.conf' do
      expect(chef_run).to render_file('/etc/iscsi/iscsid.conf').with_content(
        /node.session.timeo.replacement_timeout += +15/
      )
    end

    it 'executes udevadm control --reload-rules' do
      expect(chef_run).to_not run_execute('udevadm control --reload-rules')
    end

    it 'udev template notifies udevadm control --reload-rules' do
      expect(udev_template).to notify('execute[udev_reload_rules]').to(:run)
    end

    %w(iscsid iscsi netfs).each do |iscsi_service|
      it "#{iscsi_service} service will be started" do
        expect(chef_run).to start_service(iscsi_service)
      end

      it "#{iscsi_service} service will be enabled" do
        expect(chef_run).to enable_service(iscsi_service)
      end
    end
  end
end
