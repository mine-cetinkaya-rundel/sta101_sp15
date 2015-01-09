If you want to potentially contribute to this repository, then you need to fork it.  However, this is a relatively complicated procedure and it is easier to just clone the repository, customize it, and never worry about contributing.  That being said, you will be foregoing the chance to contribute to this work.

Below we describe how to fork, sync, and contribute to Mine's repository.

First, create a Github account.  Then follow the instructions on this page <https://help.github.com/articles/fork-a-repo/> to fork the repository.  Adding the upstream version is important for syncing any changes Mine makes.

Forking instead of cloning is useful if you want to make small contributions to the main repository.  If you think that you might do this I recommend creating a new branch as well.

Git lets you keep track of multiple versions of the repository, which are called branches.  The main branch is usually called "master".  You can see what branches exist by doing
```
$ git branch --list
```
Initially, you should only see master:
```
* master
```
To create a new branch do:
```
$ git branch custom
```
List the branches to make sure it worked:
```
$ git branch --list
custom
* master
```
The star indicates which branch you are on.  You "checkout" branches to switch between them.  To checkout custom you do
```
$ git checkout custom
```
You can now make changes to your custom repository, like adjusting the schedule for your class in the web documents.

If Mine makes changes to her master branch, then you can incorporate those changes.  *Checkout the master branch* and then do
```
$ git fetch upstream
$ git merge upstream/master
```
This document <https://help.github.com/articles/syncing-a-fork/> describes the process in more detail.

Conversely, you might want to make a change that Mine would want to incorporate into her repository.  To do that checkout the master branch and make your changes.  You can then do a pull request if you have set up your forked branch properly.  See <https://help.github.com/articles/using-pull-requests/>.

After you have updated your master branch, you can merge that update to your custom branch.  Switch to custom and then merge the changes:
```
$ git checkout custom
$ git merge master
```

