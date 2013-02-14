#!/bin/bash

cat regions_dump.list | xargs -I {} ./dump_region.sh $1{};

