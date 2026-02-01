#!/bin/sh -l
set -e

echo "OUTPUT_DIR: $OUTPUT_DIR"
echo "MAIN_LATEX_FILE: $MAIN_LATEX_FILE"
echo "CTAN_PACKAGES: $CTAN_PACKAGES"
echo "TOC: $TOC"

tlmgr install xetex

if [ -z "$CTAN_PACKAGES" ] ; then
	echo No package to install;
else
	tlmgr install $CTAN_PACKAGES;
fi

mkdir -p $OUTPUT_DIR

if [ "$TOC" = true ] ; then
	lualatex $MAIN_LATEX_FILE
fi

lualatex -output-directory $OUTPUT_DIR $MAIN_LATEX_FILE

time=$(date)
echo "time=$time" >> $GITHUB_OUTPUT
