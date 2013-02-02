#!/bin/bash

while [ -n "$1" ];
do
    case "$1" in
        -r | --region ) REGION="$2"; shift 2;;
        -h | --host ) HOST="$2"; shift 2;;
        -u | --user ) USER="$2"; shift 2;;
        -p | --password ) PASS="$2"; shift 2;;
        -d | --database ) DB="$2"; shift 2;;
        -t | --table ) TABLE="$2"; shift 2;;
        * ) shift 1;;
    esac
done

HOST=${HOST:-'localhost'}
TABLE=${TABLE:-'buildings'}

echo "Update $REGION:"

echo "Extract..."
bzip2 -d -k -f ../dumps/$TABLE/$REGION.sql.bz2

echo "Import..."
cat ../dumps/$TABLE/$REGION.sql | mysql -h $HOST -u $USER -p $PASS $DB

echo "Clear..."
rm ../dumps/$TABLE/$REGION.sql

