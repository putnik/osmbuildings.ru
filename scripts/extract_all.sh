#!/bin/bash

USER=$1
PASS=$2
DB=$3

cat regions.list | xargs -I {} ./extract_region.sh $9{} $USER $PASS $DB;

