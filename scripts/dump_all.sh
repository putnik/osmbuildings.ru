#!/bin/bash

cat regions.list | xargs -I {} ./dump_region.sh $1{} buildings_test;

