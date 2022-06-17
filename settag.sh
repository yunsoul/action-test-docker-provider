#!/bin/sh

git push origin main

git tag -d v1.0
git push origin --delete v1.0

git tag v1.0
git push origin v1.0
