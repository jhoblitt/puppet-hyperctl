require 'spec_helper'

describe 'hyperctl', :type => :class do
  context 'on osfamily RedHat' do
    let(:facts) {{ :osfamily => 'RedHat', :operatingsystemmajrelease => 6 }}

    context 'default params' do
      it 'should install hyperctl gem' do
        should contain_package('hyperctl').with(
          :ensure   => 'present',
          :provider => 'gem',
        )
      end

      it 'should manage hyperctl conf file' do
        should contain_file('hyperctl-conf').with(
          :ensure => 'present',
          :owner  => 'root',
          :group  => 'root',
          :mode   => '0644',
          :path   => '/etc/sysconfig/hyperctl',
        )
      end

      it 'conf file notfies service' do
        should contain_file('hyperctl-conf').
          that_notifies('Service[hyperctl]')
      end

      it 'should set values in hyperctl conf file' do
        should contain_file('hyperctl-conf').
          with_content(/^HYPERCTL_SET="enable"/)
      end

      it 'should manage hyperctl init script' do
        should contain_file('hyperctl-init').with(
          :ensure => 'present',
          :owner  => 'root',
          :group  => 'root',
          :mode   => '0755',
          :path   => '/etc/init.d/hyperctl',
        )
      end

      it 'init script notfies service' do
        should contain_file('hyperctl-init').
          that_notifies('Service[hyperctl]')
      end

      it 'should manage hyperctl service' do
        should contain_service('hyperctl').with(
          :ensure     => 'running',
          :hasstatus  => true,
          :hasrestart => true,
          :enable     => true,
        )
      end

      it 'service should require package' do
        should contain_service('hyperctl').
          that_requires('Package[hyperctl]')
      end
    end # default params

    context 'state =>' do
      context 'enable' do
        let(:params) {{ :state => 'enable' }}

        it 'should set values in hyperctl conf file' do
          should contain_file('hyperctl-conf').
            with_content(/^HYPERCTL_SET="enable"/)
        end
      end

      context 'disable' do
        let(:params) {{ :state => 'disable' }}

        it 'should set values in hyperctl conf file' do
          should contain_file('hyperctl-conf').
            with_content(/^HYPERCTL_SET="disable"/)
        end
      end

      context 'true' do
        let(:params) {{ :state => true }}

        it 'should fail' do
          should raise_error(Puppet::Error,
            /#{Regexp.escape('does not match "^enable$|^disable$"')}/)
        end
      end
    end # state =>

    context 'unsupported major release' do
      before do
        facts[:operatingsystemmajrelease] = '5'
        facts[:operatingsystem] = 'RedHat'
      end

      it 'should fail' do
        should raise_error(Puppet::Error, /not supported on RedHat 5/)
      end
    end # unsupported major release
  end # on osfamily RedHat

  describe 'unsupported osfamily' do
    let :facts do
      {
        :osfamily        => 'Debian',
        :operatingsystem => 'Debian',
      }
    end

    it 'should fail' do
      should raise_error(Puppet::Error, /not supported on Debian/)
    end
  end # unsupported osfamily
end
