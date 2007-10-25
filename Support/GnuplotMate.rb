class GnuplotMate
  
  def path
    possible_paths = [ENV["TM_GNUPLOT"], `which gnuplot`, "/opt/local/bin/gnuplot", "/sw/bin/gnuplot"]
    possible_paths.select { |x| x && File.exist?(x) }.first
  end

  def self.run
    g = GnuplotMate.new
    g.run_plot_in_aquaterm(STDIN.read)
  end

  def run_plot_in_aquaterm(data)
    # Delete term lines, change output lines to "term aqua" in order to show plots in Aquaterm
    data.gsub!(/^\s+set term.*$/, "")
    plotnum = 0;
    data.gsub!(/^set output.*$/, "set term aqua #{plotnum += 1}")

    execute data
  end

  def execute(script)
    IO.popen(path, 'w') do |plot|
      plot.puts script
    end
  end
end