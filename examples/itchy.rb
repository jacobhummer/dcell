#!/usr/bin/env ruby

require 'dcell'
require 'optparse'
require_relative 'registry'

id = 'itchy'

class Itchy
  include Celluloid

  attr_accessor :res, :n

  def initialize
    puts "Ready for mayhem!"
    @n = 0
    @res = 0
  end

  def fight
    @n += 1
    if @n % 6 == 0
      puts "Bite!"
    else
      puts "Fight!"
    end
    @n
  end

  def work(value)
    @n += 1
    res = 0
    100000.times do
      res += (value + 1) ** 2
    end
    @res += res
    res
  end
end

if __FILE__ == $0
  OptionParser.new do |opts|
    opts.banner = "Usage: itchy.rb [options]"

    opts.on("--id ID", "Assign node ID") do |v|
      id = v
    end
  end.parse!

  Itchy.supervise_as :itchy
  puts "Starting itchy with ID '#{id}'"
  DCell.start :id =>id, :registry => registry
  sleep
end
