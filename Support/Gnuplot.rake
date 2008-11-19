require 'rake/clean'

PLOTFILES = FileList['*.plt']
EPSFILES = FileList.new

PLOTFILES.each do |x|
  t = File.read x
  outfiles = t.scan(/^[^%]*?(['"])(.*\.dat)\1/).map { |y| y[1] }

  t.scan(/^\W*set output\W+(['"])(.*)\1/) do |y|
    EPSFILES << y[1]
    file y[1] => ([x] + outfiles) do |f|
      sh "gnuplot #{f.prerequisites[0]}"
    end
  end
end

PDFFILES = EPSFILES.ext("pdf")
CLEAN << EPSFILES + PDFFILES

rule ".pdf" => ".eps" do |f|
  sh "bash epstopdf #{f.source}"
end

desc "Removes EPS files"
task :cleaneps do
  EPSFILES.each do |x|
    rm x if (File.exist? x)
  end
end

desc "Builds all gnuplot files"
task :default => PDFFILES