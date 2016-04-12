#!/bin/bash

# aliases
alias s="git status"
alias a="git add"
alias f="git fetch"
alias c="git commit"
alias l="git log --graph"
alias p="git cherry-pick"
alias r="git reset --hard HEAD"

# ammend indexed changes.
# args: $1 - update message
function amend
{
    local MSG=$1
    if [[ "$1" == "" ]]; then
      local MSG=$(git log --oneline --pretty=%B -1 2> /dev/null)
    fi
    git commit --amend -m "${MSG}"
}

# push branch to remote
function push
{
   branch=$(git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3);
   git push origin ${branch} $@
}

# remove branch from local and remote
function remove
{
   if [[ "$1" != "" ]]; then
     local branch=$1;
     git push --delete origin ${branch}
     git branch -D ${branch};
   fi
}