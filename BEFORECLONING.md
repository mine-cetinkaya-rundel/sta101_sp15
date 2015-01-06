It is probably best to fork the main repository instead of clone it.

First, create a Github account.  Then follow the instructions on this page <https://help.github.com/articles/fork-a-repo/> to fork the repository.

You can then clone your forked repository.

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

Sometimes you might want to make a change that Mine would want to incorporate into her repository.  To do that checkout the master branch and make your changes.  You can then do a pull request if you have set up your forked branch properly.  See <https://help.github.com/articles/using-pull-requests/>.

Conversely, if Mine makes changes to her master branch, then you can incorporate those changes.  Checkout the master branch and then do
```
$ git merge upstream/master
```
This document <https://help.github.com/articles/syncing-a-fork/> describes the process in more detail.

After you have updated your master branch, you can merge that update to your custom branch.
```
$ git merge master custom
```
Once those changes are merged, go back to your custom branch to access the personalizations
```
$ git checkout custom
```

