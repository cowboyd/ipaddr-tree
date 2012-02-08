# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ipaddr/tree/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Charles Lowell"]
  gem.email         = ["cowboyd@thefrontside.net"]
  gem.description   = %q{Map IP Space onto a binary tree}
  gem.summary       = %q{Sometimes it's helpful to be able to navigate around CIDR space like you would a tree}
  gem.homepage      = "http://github.com/summon/ipaddr-tree.rb"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "ipaddr-tree"
  gem.require_paths = ["lib"]
  gem.version       = IPAddr::Tree::VERSION

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "pry"
end
