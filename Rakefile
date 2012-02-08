#!/usr/bin/env rake
require "bundler/gem_tasks"

task :console do
  $:.unshift File.expand_path '../lib', __FILE__
  require 'pry'
  require 'ipaddr/tree'
  Pry.cli = true
  Pry.start binding, {
    :prompt => [
      proc {|obj, *| "ip::tree> "},
      proc {|obj, *| "ip::tree* "}
    ],
    :hooks => Pry::Hooks.from_hash({
      :before_session => proc {|output, *| output.puts "IPAddr::Tree kicks the ass!"}
    })
  }
end
