#!/bin/bash
BRANCHES=(
nonprod
nonprod-east
nonprod-west
)
#ORIGINALBRANCH=`git status | head -n1 | cut -c13-`
ORIGINALBRANCH=`git status`
git commit -m $1
#CHERRYCOMMIT=`git log -n1 | head -n1 | cut -c8-`
CHERRYCOMMIT=`git log`
for BRANCH in "${BRANCHES[@]}";
do
    git stash;
    git checkout $BRANCH;
    git cherry-pick $CHERRYCOMMIT;
    git checkout $ORIGINALBRANCH;
    git push $BRANCH;
    git stash pop;
done
