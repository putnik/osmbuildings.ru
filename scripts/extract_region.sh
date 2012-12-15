#!/bin/bash

REGION=$1
USER=$2
PASS=$3
DB=$4

echo "Update $REGION:"

echo "Extract..."
bzip2 -d -k -f ../dumps/$REGION.sql.bz2

echo "Import..."
cat ../dumps/$REGION.sql | mysql -u$USER -p$PASS $DB

echo "Clear..."
rm ../dumps/$REGION.sql

