#!/usr/bin/env ruby -w

$LOAD_PATH << "#{ENV['TM_SUPPORT_PATH']}/lib"
$LOAD_PATH << "#{ENV['TM_SUPPORT_PATH']}/lib/tm"
$LOAD_PATH << "#{ENV['TM_BUNDLE_SUPPORT']}/lib"

# require 'rubygems'
# require 'bluecloth'
require 'markdown'
require 'gnuplot_help'
include Gnuplot
include TextMate

if __FILE__ == $0
  word = ARGV.shift || STDIN.read
  help = convert(word)
  puts Markdown.to_html(help)
  # bc = BlueCloth.new(help)
  # puts bc.to_html
end