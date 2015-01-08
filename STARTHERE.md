This file provides a brief description of what you will find in this repository and how to create certain documents.

Make sure to read BEFORECLONING.md before proceeding with changes!

# Slides

The slides are written in latex.  There are actually several different ways to compile latex files.  The slides use a special package that enables one to pick the font---a non-trivial task for latex as of 2014.  In order to use that package one must compile the files using xelatex.  Some other packages are incompatible with xelatex, such as inputenc.  So take care when reading error messages to look for such behavior.

# Key Correspondence

In the Logistics folder you will find some key emails to students.

# Webpage

## Compiling the website

The webpage is built using Jekyll.  Jekyll is kind of like a webpage compiler.

To see how this works, start by changing to the website directory and then looking at `_compile.yml`, which is a configuration file.  It is written in YAML.  It lays out the structure of the website.  From there you can get an idea of the different directories for the site.  In `_compile.yml` you will need to edit `baseurl`, `author name`, and `author url`.

The pages are written in markdown, which is relatively easy to learn.  For instance, you can look at `syllabus/index.md` do see one such markdown file.

A webpage always looks for `index.html` if given a directory instead of a file name.  This is why inside the various directories you find different `index.md` files.  Jekyll (using pandoc or some such program) will convert the `index.md` file to an `index.html` file.

The `_site` directory is important.  This is where the compiled website wil go.

<Sta101_S15_web/Makefile> shows how to compile the webpage.  In particular, do
```
make build
```
to build the website.  You can then preview the website by doing
```
make serve
```.
This will run a small webserver that let's you view the website on port 4000 (or perhaps some other port if so specified).  Look at the output to see the correct address.  It should be something like `http://127.0.0.1:4000/` or `http://localhost:4000/`.  Jekyll will automatically update that site as you edit files.

To transfer the files you need to set the approprate variables in `Makefile` and then do `make push`, which syncs the `_site` directory via `rsync`.

## Jekyll

For instructions on installing jekyll, go here: <http://jekyllrb.com/docs/installation/>.

Briefly, to install Jekyll do
```
sudo gem install jekyll
```.

You may need to restart your shell for bash to see jekyll.

## Ruby

I ran into some trouble when install Jekyll on Mac OS X.  Specifically, I ran
into a problem with the Ruby versioning.

I ended up using the following two pages:
- <http://www.iheinrich.com/wordpress/?p=154>
- <https://github.com/sstephenson/rbenv#command-reference>

`rbenv` is a program that let's you install different versions of Ruby.  It will set the path to the correct version.

You will need to install [Homebrew](http://brew.sh/), which is relatively easy, to install `rbenv`.  Once you have Homebrew installed do
```
brew install rbenv ruby-build
```
You will need to adjust your paths accordingly.  To see how to do that run `rbenv init`.  It tells you to put `eval "$(rbenv init -)"` in your .profile.

**Note**: When installing Homebrew you add the path to the Homebrew binaries in your `PATH` variable.  You will need to put `eval "$(rbenv init -)"` after you update the PATH variable in `.profile` (or whatever) so that bash knows where `rbenv` is.

## Schedule

The schedule is created using a .csv file.  Go to `_include/`.  It will have a .csv file you can edit to create your schedule.  Jekyll will use this .csv file to create a corresponding html table.

# Grading

Do as much of the grading as possible on Sakai.  You should be able to do
everything except the Clicker, Individual Readiness Assessment grades, and peer
evaluations on Sakai.

# Roster

There are several ways to download a spreadsheet of the student's in your class: Sakai and Storm.

To get your roster via Sakai go to Gradebook -> All Grades.  On the right hand side will the buttoms "Export to CSV" and "Export to Excel" that you can use to get the roster.  You can also go to Gradebook -> Course Grades and then export the Course Grades.

To get your roster via Storm go to Self Service -> My Schedule.  Then click on the cource corresponding to the lecture.  At the top will be a tab that says "class roster".  Click on that.  At the top of the table, near "Exp Grad Term" is an Excel icon.  You can click on that to download the roster.  You can also get a "grade roster" by clicking on the appropriate tab.

# Delegating 

# iClicker

## For iClicker version 6.

Set up the course.  In the Settings tell iClicker that you are using Sakai under the LMS tab.

You will need to import the roster.  To do that, export the Course Grades on Sakai.  Then copy that file into the directory of your iClicker Class with the name `sakaigradebook.csv`.

When you open the iGrader Application it should load the names.  Click Sync in the bottom right corner to associate those names with registered Clickers.  You can then export a CSV file from iGrader and upload that back to Sakai to record the clicker scores.

Details can be found [here](http://assistly-production.s3.amazonaws.com/178165/kb_article_attachments/31733/lmsguide_Sakai2.7_original.pdf?AWSAccessKeyId=AKIAJNSFWOZ6ZS23BMKQ&Expires=1420653356&Signature=hEchJgYbII8WmSpJhbUPb1cspJg%3D&response-content-disposition=filename%3D%22lmsguide_Sakai2.7.pdf%22&response-content-type=application%2Fpdf).  This may be a more permanent link: <http://support.iclicker.com/#ic-LMSSakai>.  Go to Sakai -> Manual Integration.  Then look for a link to the PDF below the videos.

# Student Requests

Sometimes students will make special requests about missing class or something else.

First, ask yourself if you could grant the request to everyone in class.  If you could not, then say no.

Second, tell the student that any requests they make need to be passed through their academic dean.  Their academic dean is supposed to be apprised of personal reaons that might justify a student missing class.  If they are unwilling to go through their dean, then it isn't a legitimate request.

# Text Editors

If multiple people are contributing to the repository it is helpful to use the same text editor.  The tex files in this repository were created using TeXShop.  TeXShop wraps lines.

In contrast, Emacs can deal with long lines in two ways.  It breaks them or wraps them.  You can toggle these behaviors by doing M-X and auto-fill-mode or visual-line-mode respectively.  Most files in this repository are created using the visual-line-mode.

* * *

# Advanced Topics

## Merging

You can use Emacs to manually merge two files.  This might be useful if you have
a custom file but want to incorporate changes made to the default file.

This
[page](https://www.gnu.org/software/emacs/manual/html_node/emacs/Overview-of-Emerge.html#Overview-of-Emerge)
shows how to invoke emerge while this
[page](https://www.gnu.org/software/emacs/manual/html_node/emacs/Merge-Commands.html#Merge-Commands)
shows how to control the merging process.
