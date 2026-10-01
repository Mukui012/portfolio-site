#!/usr/bin/env bash
set -euo pipefail

export MSYS_NO_PATHCONV=1  # stops Git Bash on Windows from rewriting "/*" into a Windows path

BUCKET="spencer-portfolio-site"
DISTRIBUTION_ID="E11RE2TKCYD1R9"

aws s3 sync . "s3://${BUCKET}" \
  --exclude ".git/*" --exclude ".gitignore" --exclude ".gitattributes" \
  --exclude "*.md" --exclude "*.png" --exclude "deploy.sh"

aws cloudfront create-invalidation \
  --distribution-id "$DISTRIBUTION_ID" \
  --paths "/*"
