require 'rake/clean'

PLOTFILES = FileList['*.plt']
EPSFILES = FileList.new

PLOTFILES.each do |x|
  t = File.read x
  t.scan(/^\W*set output\W+(['"])(.*)\1/) do |y|
    EPSFILES << y[1]
    file y[1] => x do |f|
      sh "gnuplot #{f.prerequisites[0]}"
    end
  end
  #puts `grep "^set output" #{x}`
end

PDFFILES = EPSFILES.ext("pdf")
CLEAN << EPSFILES + PDFFILES

rule ".pdf" => ".eps" do |f|
  sh "bash epstopdf #{f.source}"
end

desc "Builds all gnuplot files"
task :default => PDFFILES
#puts @plotfiles