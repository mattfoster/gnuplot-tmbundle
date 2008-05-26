#!/usr/bin/env ruby -w

require 'rubygems'
require 'bluecloth'

def convert(word = '')
  help =  "## Help for \'#{word}\'\n"
  help << `export PAGER=cat; echo help #{word} | gnuplot 2>&1`
end

if __FILE__ == $0
  word = ARGV.shift || STDIN.read
  
  help = convert(word)
  bc = BlueCloth.new(htmlize(help))
  puts bc.to_html
end