require 'spec_helper'

describe 'hyperctl::enable', :type => :class do
  context 'on osfamily RedHat' do
    let(:facts) {{ :osfamily => 'RedHat', :operatingsystemmajrelease => 6 }}

    it 'should contain hyperctl class' do
      should contain_class('hyperctl').with(
        :state => 'enable'
      )
    end
  end
end

describe 'hyperctl::disable', :type => :class do
  context 'on osfamily RedHat' do
    let(:facts) {{ :osfamily => 'RedHat', :operatingsystemmajrelease => 6 }}

    it 'should contain hyperctl class' do
      should contain_class('hyperctl').with(
        :state => 'disable'
      )
    end
  end
end
