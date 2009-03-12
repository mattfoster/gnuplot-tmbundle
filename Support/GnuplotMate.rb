class GnuplotMate
  
  def path
    possible_paths = [ENV["TM_GNUPLOT"], `which gnuplot`, "/opt/local/bin/gnuplot", "/sw/bin/gnuplot", "/usr/local/bin/gnuplot"]
    possible_paths.select { |x| x && File.exist?(x) }.first
  end

  def self.run_in_aquaterm
    g = GnuplotMate.new
    g.run_plot_in_aquaterm(STDIN.read)
  end

  def self.run
    g = GnuplotMate.new
    g.execute(STDIN.read)
  end

  def self.run_all
    script=STDIN.read
    g = GnuplotMate.new
    g.execute(script)
    g.run_plot_in_aquaterm(script)
  end

  def self.run_in_preview
    script=STDIN.read
    g = GnuplotMate.new
    g.execute(script)
    g.run_plot_in_preview(script)
  end

  def run_plot_in_preview(data)
    data.gsub!(/^set term.*$/) { "set term pdf " }
    IO.popen(path, 'w') do |plot|
      output = plot.puts data
      puts output if (output != nil)
    end
    p=IO.popen('open -a Preview.app *.pdf; open -a TextMate.app', 'r')
    p.close
  end
  
  def self.run_and_save
    script=STDIN.read
    g = GnuplotMate.new
    
    # Match the filename and set the pdf output
    filename = ENV["TM_FILEPATH"].gsub(File.extname(ENV["TM_FILEPATH"]),".pdf")    
    filename = script.match(/#!OUTPUT=(.*)$/)[1] rescue filename
    #script.gsub!(/^set term.*$/) { "" }
    script = "set term pdf\nset output \"#{filename}\"\n" + script
    # Execute
    g.execute(script)
    `osascript &>/dev/null \
  	   -e 'tell app "SystemUIServer" to activate' \
  	   -e 'tell app "TextMate" to activate' &`
  end

  def run_plot_in_aquaterm(data)
    # Delete term lines, change output lines to "term aqua" in order to show plots in Aquaterm
    data.gsub!(/^\s+set term.*$/, "")
    plotnum = 0;
    data.gsub!(/^set output.*$/) { "set term aqua #{plotnum += 1}" }
    puts data
    execute data
  end

  def execute(script)
    IO.popen(path, 'w') do |plot|
      plot.puts script
    end
  end
end
