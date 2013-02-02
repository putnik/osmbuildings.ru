#!/bin/bash

while [ -n "$1" ];
do
    case "$1" in
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

cat regions.list | xargs -I {} ./extract_region.sh -r $9{} -h $HOST -u $USER -p $PASS -d $DB -t $TABLE

