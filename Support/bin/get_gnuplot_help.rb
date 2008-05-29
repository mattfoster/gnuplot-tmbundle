#!/usr/bin/env ruby -w

$LOAD_PATH << "#{ENV['TM_SUPPORT_PATH']}/lib"
$LOAD_PATH << "#{ENV['TM_BUNDLE_SUPPORT']}/lib"

require 'rubygems'
require 'bluecloth'
require 'gnuplot_help'
include Gnuplot

if __FILE__ == $0
  word = ARGV.shift || STDIN.read
  help = convert(word)
  
  bc = BlueCloth.new(help)
  puts bc.to_html
end