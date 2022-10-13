#!/usr/bin/env bash
set -e

# Examples of call:
# git-clone-bare-for-worktrees git@github.com:name/repo.git
# git-clone-bare-for-worktrees git@github.com:name/repo.git master
#
# => Clones to a /repo directory

url=$1
basename=${url##*/}
# name=${2:-${basename%.*}} # no need to rename
name=${basename%.*}
default_branch=${2:-main}

mkdir $name
cd "$name"

# Moves all the administrative git files (a.k.a $GIT_DIR) under .bare directory.
#
# Create worktrees as siblings of this directory.
# Example targeted structure:
# .bare
# main
# new-awesome-feature
# hotfix-bug-12
# ...
git clone --bare "$url" .bare
echo "gitdir: ./.bare" > .git

# Explicitly sets the remote origin fetch so we can fetch remote branches
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Gets all branches from origin
git fetch origin

# add upstream for default branch
git branch --set-upstream-to=origin/${default_branch} ${default_branch}

# add default branch worktree
git worktree add $default_branch
