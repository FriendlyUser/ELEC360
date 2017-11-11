## Converting latex files to html

Some commands from tex will not transfer over to html, consider using webtex, just taking screenshots like just like matlab does.

Quality is pretty good, of course pictures need to be added as well, pathing for pictures needs to be absolute and not specified using image path in graphicx, and this is fine as drag and drop works for images, not need to write things out by hand.

Maybe I'll compile all my assignments and dump then on the web, or perhaps I'll make a series of html pages using all of these, who knows. Overall, pandoc conversion from latex --> html is solid.
using link from
* https://gist.github.com/killercup/5917178

pandoc -s --listings "C:\Users\wu\Downloads\University Fun\School\Fall 2017\ELEC360\Self Made Slides or Content\Assignments\A2\latex\ELEC360A2m.tex" --css pandoc.css --mathjax -o testing.html