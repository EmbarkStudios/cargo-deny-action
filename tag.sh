#!/bin/bash
set -eu

version=$1
deny_version=$2

awk -i inplace -v dvers="$deny_version" '{sub(/ENV\sdeny_version=[^\n]+/,"ENV deny_version=\"" dvers "\"")}1' Dockerfile

git add Dockerfile && git commit -m "Bump to $deny_version"

# Add the new tag
git tag -a "v$version" -m "Release $version - cargo-deny $deny_version"

# Move the v1 tag to the new commit
git tag -fa "v1" -m "Release $version - cargo-deny $deny_version"

git push --tags --force
git push