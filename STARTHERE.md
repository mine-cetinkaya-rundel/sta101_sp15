This file provides a brief description of what you will find in this repository and how to create certain documents.

Make sure to read BEFORECLONING.md before proceeding with changes!

# Slides

The slides are written in latex.  There are actually several different ways to compile latex files.  The slides use a special package that enables one to pick the font---a non-trivial task for latex as of 2014.  In order to use that package one must compile the files using xelatex.  Some other packages are incompatible with xelatex, such as inputenc.  So take care when reading error messages to look for such behavior.

# Webpage

The webpage is built using jekyll.

For instructions on installing jekyll, go here: <http://jekyllrb.com/docs/installation/>.

See <Sta101_S15_web/Makefile> for how to compile the webpage.

# Schedule

The schedule is created using a .csv file.


# Text Editors

If multiple people are contributing to the repository it is helpful to use the same text editor.  The tex files in this repository were created using TeXShop.  TeXShop wraps lines.

In contrast, Emacs can deal with long lines in two ways.  It breaks them or wraps them.  You can toggle these behaviors by doing M-X and auto-fill-mode or visual-line-mode respectively.  Most files in this repository are created using the visual-line-mode.
