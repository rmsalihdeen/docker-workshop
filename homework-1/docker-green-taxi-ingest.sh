#!/bin/bash

## bash script to run the ingestion container
echo "Running data ingestion for November 2025..."

docker run -it --rm \
--network=homework-1_default \
green_taxi_ingest:v001 \
--pg-user=root \
--pg-pass=root \
--pg-host=pgdatabase \
--pg-port=5432 \
--pg-db=ny_taxi \
--trip-table-name=green_trips_data_2025_11 \
--zone-table-name=zones

echo "Successfully done!"