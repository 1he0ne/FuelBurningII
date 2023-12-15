# TJ23_SHMUP
Our Tavern Jam 2023 game
------------------------

I suggest that we use the following repository merge strategy:


Please follow this workflow:

## Contributing new features

### 1. Checkout and update main

When you want to make a new feature, checkout the 'main' branch and fetch/pull the changes from remote
-> This means that your local repository will include the changes that were made in the meantime.


### 2. Create or checkout your dev branch

We do not want to commit and push directly to main to prevent conflicts, we want to use our own development branches instead.
Please name them e.g. devKeimo or dev/vaia so you know which one is "yours".

If you already have a branch, select (checkout) it. If you don't have one yet, or you deleted it, make a new one (branch from main), then checkout.


### 3. update your dev branch (merge main into dev, or rebase dev on main)

We usually want to build from the latest version with all the features of all contributors.
The main repository now includes the latest changes, so we want to make sure our dev branch is up to date.

If you branched from main, and created a new branch, you will already be up to date.
If you kept your branch, you need to 
-> merge main into your dev branch
or
-> rebase your dev branch onto main

Alternatively, checkout main, delete your dev branch, and create a new dev branch from main.

### 4. develop your feature

Write new code, build a level, upload graphics, music and sound... 
If another developer added new graphics for you, you can merge their changes at any time (which should be in main, if they followed this guideline)

### 5. (optional) integrate changes from other devs while working on your feature

To integrate the new changes, it can be a bit annoying with git.

You first need to commit your changes to your branch (to keep them safe, just in case multiple devs worked on the same level or script)
Then checkout main, update (fetch/pull) main, checkout your dev branch.
Finally, merge main into your dev branch.

If conflicts occur, you need to decide what to do: keep your own changes, keep the changes from main, or create a combination.
Merging a combination is only really possible in text files and code, but won't be possible with assets (and most of the time won't work with scenes, unless you are lucky).

It's bad practice, but you can always send source code directly to another dev... but ideally, we should resolve the git conflicts manually.

### 6. your feature is done, and ready to be merged to main

If you created new assets, code, levels, ... you'll want to share it with your teammates, so they can integrate your changes.
Please follow these steps:

-> Commit your changes to your dev branch
-> Checkout main
-> Fetch & Pull main (in case somebody else completed a feature before you)
-> Merge your dev branch into main, and resolve conflicts (for assets, please talk to the dev, if you want to replace their asset with yours, for code, use your best judgment, and/or talk to the dev who changed the same file as you)

### 7. update or rebase or delete your dev branch and make a new one

If there were no changes on main during step 6, your dev branch will be at the most recent state.
It's likely that another dev did make some changes to the project on main (even if the files didn't conflict, they might have added new files).
If there were changes on main, you want to integrate them into your dev branch, and you have a few options for achieving that:

A) checkout your dev branch, then merge main into dev
OR
B) checkout your dev branch, then rebase onto main
OR
C) delete your dev branch, then make a new dev branch, starting from main

### Repeat steps 3-7, until the game is finished :)


## Branch overview

### dev/*

These are our personal branches where we can freely add scripts, assets, artwork, ...
When we are done with our work, we'll merge it with 'main' :)

### main

Should always contain the "bleeding edge" newest version.
Please make sure you pull the changes from main into your personal dev branch to prevent merge conflicts.
It's better to solve merge conflicts in your dev branch then on the main branch, because:
-> you know how your dev branch should look like, and which parts you want to keep or to discard in favor of an update by a teammate 
-> but on main, you might overwrite the work of others

### releases (optional)

We probably won't use any releases and just work with main for the game jam. 
Just in case, if we want to tag a release, please checkout main, then tag a release and call it "release_x.y.z", with major/minor/patch versioning. E.g.: release_1.0.0
