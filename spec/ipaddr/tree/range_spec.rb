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

  it 'handles can handle weirdness' do
    iprange('0.0.0.4', '0.0.0.6').should eql ['0.0.0.2/31', '0.0.0.4/31', '0.0.0.6/32']
  end

  it "generates some real ranges" do
    iprange('64.70.116.50', '64.70.116.54').should eql ['64.70.116.50/31', '64.70.116.52/31', '64.70.116.54/32']
  end

  def iprange(start, finish)
    IPAddr.new(start).blocks_until(IPAddr.new(finish)).map(&:cidr_notation)
  end
end
