require 'spec_helper'

describe 'hyperctl', :type => :class do

  describe 'for osfamily RedHat' do
    it { should contain_class('hyperctl') }
  end

end
