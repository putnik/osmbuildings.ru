#!/bin/bash

REGION=$1

echo "Update $REGION"

echo "Get data:"
echo "* Download..."
wget --unlink http://data.gis-lab.info/osm_dump/dump/latest/$REGION.osm.bz2

echo "* Extract..."
bzip2 -d -f $REGION.osm.bz2

echo "* Import into PostGIS..."
osm2pgsql -U postgres -c -l -G -S ./osmbuildings.style -C 1000 $REGION.osm
psql -U postgres -d gis -c 'DELETE FROM planet_osm_polygon WHERE NOT ST_IsValid(way)'

rm -f $REGION.osm*


echo "Main table:"
TABLE='buildings'

echo "* Convert to MySQL..."
nodejs convert.js \
--pg-password osmsql \
--pg-database gis \
--pg-table planet_osm_polygon \
--pg-footprint-field way \
--my-region $REGION \
--my-table $TABLE \
--pg-height-field "ROUND(COALESCE(height, \"building:height\", levels*2.5, \"building:levels\"*2.5, 0))" \
--pg-minheight-field "ROUND(COALESCE(min_height, \"building:min_level\"*2.5, 0))" \
--pg-filter "(man_made IS NOT NULL
OR (building IS NOT NULL AND building <> 'no' AND NOT EXISTS(
	SELECT * FROM planet_osm_polygon parts
	WHERE parts.\"building:part\" IS NOT NULL
	AND ST_Within(parts.way, planet_osm_polygon.way)
))
OR \"building:part\" IS NOT NULL
OR (height > 0 AND building IS NULL))
AND ST_GeometryType(way) = 'ST_Polygon'"

echo "* Compress..."
bzip2 -z -f -9 $REGION.sql

echo "* Upload to server..."
scp $REGION.sql.bz2 root@putnik.ws:/srv/http/osmbuildings.ru/dumps/$TABLE/

rm -f $REGION.sql*


echo "Test table:"
TABLE='buildings_test'

echo "* Convert to MySQL..."
nodejs convert_test.js \
--pg-password osmsql \
--pg-database gis \
--pg-table planet_osm_polygon \
--pg-footprint-field way \
--my-region $REGION \
--my-table $TABLE \
--pg-height-field "ROUND(COALESCE(height, \"building:height\", levels*2.5, \"building:levels\"*2.5, 0))" \
--pg-minheight-field "ROUND(COALESCE(min_height, \"building:min_level\"*2.5, 0))" \
--pg-filter "(man_made IS NOT NULL
OR (building IS NOT NULL AND building <> 'no' AND NOT EXISTS(
	SELECT * FROM planet_osm_polygon parts
	WHERE parts.\"building:part\" IS NOT NULL
	AND ST_Within(parts.way, planet_osm_polygon.way)
))
OR \"building:part\" IS NOT NULL
OR (height > 0 AND building IS NULL))"

echo "* Compress..."
bzip2 -z -f -9 $REGION.sql

echo "* Upload to server..."
scp $REGION.sql.bz2 root@putnik.ws:/srv/http/osmbuildings.ru/dumps/$TABLE/

rm -f $REGION.sql*
