# Notes for 23th of April, 2024

# Keeping in Sync
 If you forked this repo and cloned it to your local machine you should at first add the original repo as an upstream source.

```
# Add a new remote upstream repository
git remote add upstream https://github.com/ORIGINAL_OWNER/ORIGINAL_REPOSITORY.git
```

Check everything with
```
git remote -v
origin    https://github.com/YOUR_USERNAME/YOUR_FORK.git (fetch)
origin    https://github.com/YOUR_USERNAME/YOUR_FORK.git (push)
upstream  https://github.com/ORIGINAL_OWNER/ORIGINAL_REPOSITORY.git (fetch)
upstream  https://github.com/ORIGINAL_OWNER/ORIGINAL_REPOSITORY.git (push)
```

## Sync your fork
Be sure you're in the root of your project and also in the main branch.
```
git checkout main
Switched to branch 'main'
```

Now, you have to fetch the changes from the original repository:
```
git fetch upstream
remote: Enumerating objects: 16, done.
remote: Counting objects: 100% (16/16), done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 7 (delta 5), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (7/7), 1.72 Kio | 160.00 Kio/s, done.
From https://github.com/ORIGINAL_OWNER/ORIGINAL_REPOSITORY
   909ef5a..0b228a8  master     -> upstream/master
```

And merge the changes in your master branch
```
git merge upstream/master
Updating 909ef5a..0b228a8
Fast-forward
 node.js/WorkingWithItems/batch-get.js               | 51 ++++++++++++++++++++++++++------------------------
 node.js/WorkingWithItems/batch-write.js             | 95 +++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------
 node.js/WorkingWithItems/delete-item.js             | 37 ++++++++++++++++++------------------
 node.js/WorkingWithItems/get-item.js                | 31 +++++++++++++++++--------------
 node.js/WorkingWithItems/put-item-conditional.js    | 51 +++++++++++++++++++++++++-------------------------
 node.js/WorkingWithItems/put-item.js                | 49 ++++++++++++++++++++++++------------------------
 node.js/WorkingWithItems/transact-get.js            | 51 ++++++++++++++++++++++++++------------------------
 node.js/WorkingWithItems/transact-write.js          | 79 ++++++++++++++++++++++++++++++++++++++++-------------------------------------
 node.js/WorkingWithItems/update-item-conditional.js | 51 ++++++++++++++++++++++++++------------------------
 node.js/WorkingWithItems/update-item.js             | 47 ++++++++++++++++++++++++----------------------
 10 files changed, 282 insertions(+), 260 deletions(-)
```
