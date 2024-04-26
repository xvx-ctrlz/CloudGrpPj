#!/bin/bash

# Install Sysbench (if not already installed)
sudo apt-get update
sudo apt-get install -y sysbench

# Database connection details
DB_DRIVER="pgsql"
DB_HOST="database-aurorapostgresql-instance-1.c7ec88qoassw.us-east-1.rds.amazonaws.com"
DB_PORT="5432"
DB_USER="postgres"
DB_PASSWORD="Passw0rd123"
DB_NAME="sbtest"

# Number of threads to use for benchmarking
NUM_THREADS="8"

# Number of total events to be processed
TOTAL_EVENTS="100000"

# Prepare the database
sysbench /usr/local/share/sysbench/oltp_read_write.lua --db-driver=$DB_DRIVER --pgsql-host=$DB_HOST --pgsql-port=$DB_PORT \
         --pgsql-user=$DB_USER --pgsql-password=$DB_PASSWORD \
         --pgsql-db=$DB_NAME \
         --table-size=10000 \
         --tables=10 \
         --threads=$NUM_THREADS \
         --time=120 \
         --report-interval=10 \
         prepare

# Run the benchmark
sysbench /usr/local/share/sysbench/oltp_read_write.lua --db-driver=$DRIVER --pgsql-host=$DB_HOST --pgsql-port=$DB_PORT \
         --pgsql-user=$DB_USER --pgsql-password=$DB_PASSWORD \
         --pgsql-db=$DB_NAME \
         --threads=$NUM_THREADS \
         --events=$TOTAL_EVENTS \
         --time=120 \
         --report-interval=10 \
         run