#!/usr/bin/env rake
require "bundler/gem_tasks"

task :console do
  def iprange(start, finish)
    IPAddr.new(start).blocks_until(finish).map(&:cidr_notation)
  end

  $:.unshift File.expand_path '../lib', __FILE__
  require 'pry'
  require 'ipaddr/tree'
  require 'ipaddr/tree/range'
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
