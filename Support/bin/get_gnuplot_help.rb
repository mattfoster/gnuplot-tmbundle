#!/usr/bin/env ruby -w

require "#{ENV['TM_SUPPORT_PATH']}/lib/tm/markdown.rb"
require "#{ENV['TM_BUNDLE_SUPPORT']}/lib/gnuplot_help.rb"

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
