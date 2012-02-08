require 'spec_helper'
require 'ipaddr/tree/range'

describe IPAddr::Tree::Range do

  it "calculates a full tree" do
    iprange('0.0.0.4', '0.0.0.7').should eql ['0.0.0.4/30']
  end

  it "calculates that is full on the left" do
    iprange('0.0.0.3', '0.0.0.7').should eql ['0.0.0.3/32', '0.0.0.4/30']
  end

  it 'generates a messed up little range' do
    iprange('0.0.0.3', '0.0.0.9').should eql ['0.0.0.3/32', '0.0.0.4/30', '0.0.0.8/31']
  end

  it "generates a range that's clipped down to a single node" do
    iprange('0.0.0.2', '0.0.0.8').should eql ['0.0.0.2/31', '0.0.0.4/30', '0.0.0.8/32']
  end

  it "generates a range that's clipped down to a single node" do
    iprange('0.0.0.2', '0.0.0.9').should eql ['0.0.0.2/31', '0.0.0.4/30', '0.0.0.8/31']
  end

  it 'ahem' do
    iprange('0.0.0.0/29', '0.0.0.6/32').should eql ["0.0.0.0/30", "0.0.0.4/31", "0.0.0.6/32"]
  end

  it 'handles can handle weirdness' do
    iprange('0.0.0.4', '0.0.0.6').should eql ['0.0.0.4/31', '0.0.0.6/32']
    iprange('155.48.168.0','155.48.171.0').should eql [
      '155.48.168.0/23',
      '155.48.170.0/24',
      '155.48.171.0/32'
    ]
  end

  it "handles some real ranges from the wild" do
    iprange('64.70.116.50', '64.70.116.54').should eql ['64.70.116.50/31', '64.70.116.52/31', '64.70.116.54/32']
    iprange('212.138.110.1','212.138.110.128').should eql [
      '212.138.110.1/32',
      '212.138.110.2/31',
      '212.138.110.4/30',
      '212.138.110.8/29',
      '212.138.110.16/28',
      '212.138.110.32/27',
      '212.138.110.64/26',
      '212.138.110.128/32'
    ]
    iprange('155.48.0.0', '155.48.255.255')
  end


  def iprange(start, finish)
    IPAddr.new(start).blocks_until(IPAddr.new(finish)).map(&:cidr_notation)
  end
end
