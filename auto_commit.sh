#!/bin/bash

# Verifica che ci siano argomenti
if [ $# -lt 2 ]; then
  echo "Usage: $0 'Commit message' 'YYYY-MM-DD HH:MM:SS'"
  exit 1
fi

# Argomenti
COMMIT_MESSAGE=$1
COMMIT_DATE=$2

# Aggiungi tutti i file modificati
git add .

# Committa con messaggio e data retroattiva
GIT_AUTHOR_DATE="$COMMIT_DATE" GIT_COMMITTER_DATE="$COMMIT_DATE" git commit -m "$COMMIT_MESSAGE"

# Pusha i commit
CURRENT_BRANCH=$(git branch --show-current)
git push origin "$CURRENT_BRANCH"
