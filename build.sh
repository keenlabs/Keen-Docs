#!/bin/bash
cd "$(dirname "$0")"

: ${KEEN_WEB_DIR?"Need to set KEEN_WEB_DIR environment variable"}
KEEN_NEW_DOCS_FOLDER="$KEEN_WEB_DIR/app/static/new-docs"

echo "Okay, first I'm going to run Sphinx."

make html
#make clean html

echo "Okay, that worked, now to delete everything in the current Keen-Web new-docs folder: $KEEN_NEW_DOCS_FOLDER"

rm -rf $KEEN_NEW_DOCS_FOLDER

echo "Sweet, now I'm going to copy everything over..."

mkdir $KEEN_NEW_DOCS_FOLDER
cp -r -v build/html/. $KEEN_NEW_DOCS_FOLDER/.