#!/bin/bash
cd "$(dirname "$0")"

echo "Okay, first I'm going to run Sphinx."

make clean html

git status

echo ""
echo "Looks like it worked!"
