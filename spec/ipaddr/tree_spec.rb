require 'spec_helper'

describe IPAddr::Tree do

  describe "a middling node like 0.0.0.4/30" do
    subject {IPAddr.new "0.0.0.4/30"}
    its(:parent) {should match_cidr "0.0.0.0/29"}
    its(:left_child) {should match_cidr "0.0.0.4/31"}
    its(:right_child) {should match_cidr "0.0.0.6/31"}
    its(:next_sibling) {should match_cidr "0.0.0.8/30"}
    its(:previous_sibling) {should match_cidr "0.0.0.0/30"}
  end

  describe "a leaf node like 0.0.0.7/32" do
    subject {IPAddr.new '0.0.0.7/32'}
    its(:left_child) {should be_nil}
    its(:right_child) {should be_nil}
  end

  describe "the far left corner" do
    subject {IPAddr.new "0.0.0.0/32"}
    its(:previous_sibling) {should be_nil}
    its(:next_sibling) {should match_cidr '0.0.0.1/32'}
  end

  describe "the far right corner" do
    subject {IPAddr.new '255.255.255.255'}
    its(:next_sibling) {should be_nil}
    its(:previous_sibling) {should match_cidr '255.255.255.254/32'}
  end

  describe "the root of the tree" do
    subject {IPAddr.new '0.0.0.0/0'}
    its(:parent) {should be_nil}
  end
end
