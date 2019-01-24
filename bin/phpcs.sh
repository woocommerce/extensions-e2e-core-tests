#!/usr/bin/env bash

CHANGED_FILES=`git whatchanged --name-only --pretty="" origin..HEAD |  grep \\\\.php$ | awk '{print}' ORS=' '`
IGNORE="includes/lib/"

if [ "$CHANGED_FILES" != "" ]; then
	echo "Running Code Sniffer."
	phpcs --standard=Extendables --ignore=$IGNORE --encoding=utf-8 -n -p $CHANGED_FILES
fi

