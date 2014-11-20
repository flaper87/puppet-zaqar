require 'puppet'
require 'puppet/type/zaqar_config'

describe 'Puppet::Type.type(:zaqar_config)' do
  before :each do
    @zaqar_config = Puppet::Type.type(:zaqar_config).new(:name => 'DEFAULT/foo', :value => 'bar')
  end

  it 'should require a name' do
    expect {
      Puppet::Type.type(:zaqar_config).new({})
    }.to raise_error(Puppet::Error, 'Title or name must be provided')
  end

  it 'should not expect a name with whitespace' do
    expect {
      Puppet::Type.type(:zaqar_config).new(:name => 'f oo')
    }.to raise_error(Puppet::Error, /Parameter name failed/)
  end

  it 'should fail when there is no section' do
    expect {
      Puppet::Type.type(:zaqar_config).new(:name => 'foo')
    }.to raise_error(Puppet::Error, /Parameter name failed/)
  end

  it 'should not require a value when ensure is absent' do
    Puppet::Type.type(:zaqar_config).new(:name => 'DEFAULT/foo', :ensure => :absent)
  end

  it 'should accept a valid value' do
    @zaqar_config[:value] = 'bar'
    @zaqar_config[:value].should == 'bar'
  end

  it 'should not accept a value with whitespace' do
    @zaqar_config[:value] = 'b ar'
    @zaqar_config[:value].should == 'b ar'
  end

  it 'should accept valid ensure values' do
    @zaqar_config[:ensure] = :present
    @zaqar_config[:ensure].should == :present
    @zaqar_config[:ensure] = :absent
    @zaqar_config[:ensure].should == :absent
  end

  it 'should not accept invalid ensure values' do
    expect {
      @zaqar_config[:ensure] = :latest
n    }.to raise_error(Puppet::Error, /Invalid value/)
  end
end

