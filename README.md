# The Gnuplot TextMate bundle

See this [screencast](http://www.vimeo.com/2181877) for quick installation instrucitons.

## Introduction

Aims to provide a useful set of commands, snippets and language support for
writing and running gnuplot scripts within [TextMate](http://macromates.com/).

So far, various features have been implemented, including:

  * Syntax hilighting.
  * Script execution -- pressing ' ⌘R' pipes the script through gnuplot.
  * Plot in aquaterm -- pressing also ''⌘R' gives you the option of viewing the plot in aquaterm.
    * Execution and display -- we now have a command for running a script and showing the result in aquaterm.
  * Output viewing -- pressing '⇧⌘O' will search though the script and open any filenames it finds after `set output` statements. 
  * Output the current file to a PDF file and specify the file name in the plot file
  * Toggling (un)set -- pressing '⇧⌘S' changes toggles between `set` and `unset` keywords on the current line.
  * Online help -- pressing '⌃H' with the caret over a keyword pops up an HTML window containing gnuplot's built-in help for that keyword.

There are a cople of issus with the help, see the end of the `fillstyle` entry, for example, but these are minor, and seem to be due to bugs in bluecloth.

Future work will be focused on providing completion, and improving the help
command -- especially formatting of the output.

## Links

  *  [Home page](http://github.com/mattfoster/gnuplot-tmbundle/)
  * [Google Group](http://groups.google.com/group/gnuplot-tmundle)

## Installation:

Run:

`cd ~/Library/Application\ Support/TextMate/Bundles`

`git clone git://github.com/mattfoster/gnuplot-tmbundle.git Gnuplot.tmbundle`

## Saving the Output of a script to a PDF file

You can specify a file name directly in the script and use ⌘R to execute the script. From the options choose save to PDF. To
specify a name in the script put the following line in the beginning of you document:

    #!OUTPUT=this_is_my_file.pdf
        
The script will parse for this option and save the generated PDF to your directory.

## Maintainer 

[Matt Foster](mailto:matt.p.foster@gmail.com) : [homepage](http://my-mili.eu/matt)

## Thanks:

Some functionality merged in from [gnuplot-textmate-bundle](http://github.com/pieter/gnuplot-textmate-bundle/tree/master "pieter's gnuplot-textmate-bundle at master &mdash; GitHub") on GitHub.

