require 'spec_helper_acceptance'

RSpec.shared_examples "hyperctl installed" do
  describe package('hyperctl') do
    it { should be_installed.by('gem') }
  end

  describe file('/etc/sysconfig/hyperctl') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
  end

  describe file('/etc/init.d/hyperctl') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 755 }
  end

  describe service('hyperctl') do
    it { should be_enabled }
    it { should be_running }
  end
end

describe 'hyperctl class' do
  describe 'default params' do
    describe 'running puppet code' do
      pp = <<-EOS
        include ::hyperctl
      EOS

      it 'applies the manifest twice with no stderr' do
        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes => true)
      end
    end

    it_behaves_like "hyperctl installed"

    describe file('/etc/sysconfig/hyperctl') do
      its(:content) do
        should match 'HYPERCTL_SET="enable"'
      end
    end
  end # default params

  describe 'state =>' do
    describe 'enable' do
      describe 'running puppet code' do
        pp = <<-EOS
          class { '::hyperctl':
            state => 'enable'
          }
        EOS

        it 'applies the manifest twice with no stderr' do
          apply_manifest(pp, :catch_failures => true)
          apply_manifest(pp, :catch_changes => true)
        end
      end

      it_behaves_like "hyperctl installed"

      describe file('/etc/sysconfig/hyperctl') do
        its(:content) do
          should match 'HYPERCTL_SET="enable"'
        end
      end
    end # enable

    describe 'disable' do
      describe 'running puppet code' do
        pp = <<-EOS
          class { '::hyperctl':
            state => 'disable'
          }
        EOS

        it 'applies the manifest twice with no stderr' do
          apply_manifest(pp, :catch_failures => true)
          apply_manifest(pp, :catch_changes => true)
        end
      end

      it_behaves_like "hyperctl installed"

      describe file('/etc/sysconfig/hyperctl') do
        its(:content) do
          should match 'HYPERCTL_SET="disable"'
        end
      end
    end # enable
  end # default params
end # hyperctl class

describe 'hyperctl::enable class' do
  describe 'running puppet code' do
    pp = <<-EOS
      include ::hyperctl::enable
    EOS

    it 'applies the manifest twice with no stderr' do
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end

  it_behaves_like "hyperctl installed"

  describe file('/etc/sysconfig/hyperctl') do
    its(:content) do
      should match 'HYPERCTL_SET="enable"'
    end
  end
end # hyperctl::enable class

describe 'hyperctl::disable class' do
  describe 'running puppet code' do
    pp = <<-EOS
      include ::hyperctl::disable
    EOS

    it 'applies the manifest twice with no stderr' do
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end

  it_behaves_like "hyperctl installed"

  describe file('/etc/sysconfig/hyperctl') do
    its(:content) do
      should match 'HYPERCTL_SET="disable"'
    end
  end
end # hyperctl::enable class
