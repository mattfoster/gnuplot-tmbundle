# Functions for converting gnuplot help to markdown
# 
# Matt Foster 2008

module Gnuplot
  def convert(word = '')
    require 'cgi'
        
    # Determine the title as needed.
    unless word.nil?
      help = "## Help for \'#{word}\'\n"
    else
      help = "## Introduction\n"
    end
    
    # Run gnuplot, and get the output
    help << `export PAGER=cat; echo help #{word} | gnuplot 2>&1`

    # Exit if there was an errror running gnuplot:
    unless $? == 0
      puts "Error running gnuplot help command." 
      puts output
      exit
    end
    
    help = help.split("\n")

    help.each_with_index do |line, ii|      
      # Escape lines which aren't indented enough to be code blocks.
      if line =~ /^\s\s?\S/
        line = CGI.escapeHTML(line)
      end
      # Convert words inside backticks to clicable links, if they follow 'See also'
      if line =~ /^\s*See also/
        line.gsub!(/`(.*?)`./, '  * <a onClick=\'help("\1")\'>\1</a>')
      end 
      help[ii] = line
    end
        
    help = help.join("\n")
    
    help.gsub!(/^\s*Syntax:\s*$/, "\n### Syntax\n")
    help.gsub!(/^\s*Examples:\s*$/, "\n### Examples\n")
    help.gsub!(/^\s*Example:\s*$/, "\n#### Example\n")
    help.gsub!(/^\s*Subtopics available for .*:\s*$/, "\n#### Subtopics\n")
    help.gsub!(/^\s*See also/, "\n#### See Also\n")
    
  end
  
  def header
    header = <<-END
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
    	"http://www.w3.org/TR/html4/strict.dtd">
    <html>
    <head>
    	<meta http-equiv="Content-type" content="text/html; charset=utf-8">
    	<title>Gnuplot Help</title>
    	<style type="text/css"> 

    	#search {
    	  float: right;
    	  text-align: right;
        height: 2em;
    	}

    	#search input {
    	  padding-left 5px;
      }

      a {
    	text-decoration: underline;
      }

      #title {
        float: left;
        text-align: left;
      }
      .clear{
        clear: both;
      }

      pre {
        width: 98%;
        border: thin solid gray;
        background: black;
        color: #bbb;
        padding: 1%;
      }

    	</style>  
      <script>
      function help (arg) {
        var cmd = "get_gnuplot_help.rb '" + arg + "'";
        var res = TextMate.system(cmd, null).outputString;
        document.getElementById("output").innerHTML = res;
        window.location.hash = "output";
      }

      function run_search () {
        var com = document.f.com.value;

        document.f.com.value = "";
        var cmd = "get_gnuplot_help.rb '" + com + "'";
        var res = TextMate.system(cmd, null).outputString;
        document.getElementById("output").innerHTML = res;
        window.location.hash = "output";
      }
      </script>
    </head>
    <div id="title">
      Gnuplot Help
    </div>
    <div id="search">
      <form id="input_form" name="f" onsubmit="javascript: run_search(); return false" action="#">
      Search:<input maxlength="256" size="20" name="com" value="">
      <input value="Search" type="submit">
    </div>

    <div class="clear">
    <hr>
    </div>
    END
  end
  
end