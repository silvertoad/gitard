#!/bin/bash

# aliases
alias s="git status"
alias a="git add"
alias f="git fetch"
alias c="git commit"
alias l="git log --graph"
alias p="git cherry-pick"
alias r="git reset --hard HEAD"

function rb
{
    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/');
    git pull --rebase origin ${branch} $@
}

function rbi
{
    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/');
    merge_base=$(git merge-base origin/$branch HEAD)
    git rebase -i $merge_base
}


# extract today tasks logged by user
function today
{
    git log --oneline --format=%s --author="$(git config --get user.name)" --after="$(date +"%Y-%m-%d") 00:00"
}

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
   branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/');
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
