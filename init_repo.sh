#!/usr/bin/env bash
set -e

# Usage: ./init_repo.sh [remote-url] [branch]
# Example: ./init_repo.sh git@github.com:owner/cloud-kitchen.git main

REMOTE_URL=$1
BRANCH=${2:-main}

if [ ! -d .git ]; then
  git init
  git add .
  git commit -m "chore: initial commit - cloud kitchen"
  git branch -M "$BRANCH"
  echo "Initialized local git repository and committed to branch '$BRANCH'."
else
  echo "Git repository already initialized."
fi

if [ -n "$REMOTE_URL" ]; then
  git remote add origin "$REMOTE_URL" || git remote set-url origin "$REMOTE_URL"
  echo "Remote set to $REMOTE_URL"
  git push -u origin "$BRANCH"
  echo "Pushed to remote."
else
  echo "No remote provided. To push, run: git remote add origin <url> && git push -u origin $BRANCH"
fi
