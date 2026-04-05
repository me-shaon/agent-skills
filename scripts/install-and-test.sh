#!/usr/bin/env bash

set -euo pipefail

OWNER_REPO="UNSPECIFIED"
SKILLS=(
  "deployment-readiness"
  "migration-index-reviewer"
  "api-hardening-patterns"
  "upgrade-assistant"
  "resilient-check"
)

echo "Install commands:"
for skill in "${SKILLS[@]}"; do
  echo "npx skills add ${OWNER_REPO} --skill ${skill}"
  echo "php artisan boost:add-skill ${OWNER_REPO} --skill ${skill}"
done

echo
echo "Expected output:"
echo "  Resolving repository skills..."
echo "  Copying selected skill into the target agent skills directory..."
echo "  Skill installed successfully."
echo
echo "Expected Boost output:"
echo "  Discovering skills from repository..."
echo "  Installing selected skill..."
echo "  Skill installed successfully."
echo
echo "Replace OWNER_REPO in this script with your published GitHub repository before running it for real."
