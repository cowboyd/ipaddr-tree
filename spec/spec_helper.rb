require 'ipaddr/tree'

RSpec::Matchers.define :match_cidr do |expected|
  match do |actual|
    actual.cidr_notation == expected
  end
end