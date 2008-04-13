#!/usr/bin/env ruby
#
# Gnuplot completion functions
#
# Run using:
# echo set | gnuplot 2>&1 | egrep -o "'.*'" | tr ',' '\n' | \
# ~/Documents/expand_gnuplot.rb
# 
# For a list that can be used in a language grammar, use something like:
# echo match = \'\\b\($(./expand_gnuplot.rb set | tr -t "\n" "|")\)\\b\'
#
# Matt Foster <matt.p.foster@gmail.com>


# Gnuplot Expander
#
# Expand things of the form:
# * {[xyz]{2}}zeroaxis
# * {no}{m}[xyz]{2}tics
# * [blrt]margin
# * [rtuv]range
# * [xyz]{2}[md]tics
# * [xyz]{2}data
# * [xyz]{2}label
# * [xyz]{2}range
# E.g.:
# expand_brackets('{[xyz]{2}}zeroaxis') => 
#   ["x2zeroaxis", "xzeroaxis", "y2zeroaxis", 
#    "yzeroaxis", "z2zeroaxis", "zeroaxis", 
#    "zzeroaxis"]
class GnuplotExpander
    
  # Expand out curly braces.
  # These are optional parts, so return the string with and without them.
  # E.g.:
  # expand_curly('{ab}c') # => ["c", "abc"]
  def expand_curly(strings)
    out = []
    strings.each do |string|
      # look for {...}
      string.match(/(.*)\{([\w\d]*)\}(.*)/)

      pre = $1
      mid = $2
      post = $3

      out.push "#{pre}#{post}"
      if mid
        out.push "#{pre}#{mid}#{post}"
      end
    end

    out
  end

  # Expand out curly braces.
  # expand_square('[ab]c') => ["ac", "bc"]
  def expand_square(strings)
    # look for [...]
    out = []  
    strings.each do |string|  
      string.match(/(.*)\[([\w\d]*)\](.*)/)

      pre = $1
      mid = $2
      post = $3

      if mid
        mid.split('').each do |opt|
          out.push "#{pre || ''}#{opt}#{post}"
        end
      end
    end

    out
  end

  # Expand a bracketed gnuplot expression
  # Overall order of operations:
  # 1. count opening curlies and brackets
  # 2. Run expand_curly appropriately
  # 3. Run expand_square appropriately
  def expand_brackets(string)
    curlies = string.count('{')
    squares = string.count('[')

    squares.times do
      string = expand_square(string)
    end

    curlies.times do
      string = expand_curly(string)
    end

    # Remove duplicates left by my sloppy coding
    if string.respond_to?(:uniq)
      string.uniq.sort
    else
      string
    end

  end
end

if __FILE__ == $0
  
  # Looks for a keyword on the command line
  keyword = ARGV.shift 
  puts keyword
  if keyword
    gnuplot_output = `echo "#{keyword}"| gnuplot 2>&1`
  else
    $stderr.puts "Expected keyword as argument."
    $stderr.puts "Usage: #{File.basename($0)} keyword"
    exit 1
  end
  
  exp = GnuplotExpander.new
  
  gnuplot_output.split(/,|\s/).grep(/'(.*)'/) do
    puts exp.expand_brackets($1)
  end
end