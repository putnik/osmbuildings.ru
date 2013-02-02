#!/bin/bash

REGION=$1
USER=$2
PASS=$3
DB=$4
TABLE=$5

echo "Update $REGION:"

echo "Extract..."
bzip2 -d -k -f ../dumps/$TABLE/$REGION.sql.bz2

echo "Import..."
cat ../dumps/$TABLE/$REGION.sql | mysql -u$USER -p$PASS $DB

echo "Clear..."
rm ../dumps/$TABLE/$REGION.sql

