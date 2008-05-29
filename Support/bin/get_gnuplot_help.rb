#!/usr/bin/env ruby -w

require 'rubygems'
# require 'escape'
require 'bluecloth'

def convert(word = '')
  help =  "## Help for \'#{word}\'\n"
  help << `export PAGER=cat; echo help #{word} | gnuplot 2>&1`
end

if __FILE__ == $0
  word = ARGV.shift || STDIN.read
  help = convert(word)
  
  help.gsub!(/^\s*Syntax:\s*$/, "\n### Syntax\n")
  help.gsub!(/^\s*Examples:\s*$/, "\n### Examples\n")
  help.gsub!(/^\s*Example:\s*$/, "\n#### Example\n")
  help.gsub!(/^\s*Subtopics available for .*:\s*$/, "\n#### Subtopics\n")
  help.gsub!(/^\s*See also/, "\n#### See Also\n\t")
  
  bc = BlueCloth.new(help)
  puts bc.to_html
end