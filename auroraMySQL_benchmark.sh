#!/bin/bash

# Install Sysbench (if not already installed)
sudo apt-get update
sudo apt-get install -y sysbench

# Database connection details
DB_DRIVER="mysql"
DB_HOST="database-auroramysql-instance-1.c7ec88qoassw.us-east-1.rds.amazonaws.com"
DB_PORT="3306"
DB_USER="admin"
DB_PASSWORD="Passw0rd123"
DB_NAME="sbtest"

# Number of threads to use for benchmarking
NUM_THREADS="8"

# Number of total events to be processed
TOTAL_EVENTS="100000"

# Prepare the database
sysbench /usr/local/share/sysbench/oltp_read_write.lua --db-driver=mysql --mysql-host=$DB_HOST --mysql-port=$DB_PORT \
         --mysql-user=$DB_USER --mysql-password=$DB_PASSWORD \
         --mysql-db=$DB_NAME \
         --table-size=10000 \
         --tables=10 \
         --threads=$NUM_THREADS \
         --time=120 \
         --report-interval=10 \
         prepare

# Run the benchmark
sysbench /usr/local/share/sysbench/oltp_read_write.lua --db-driver=mysql --mysql-host=$DB_HOST --mysql-port=$DB_PORT \
         --mysql-user=$DB_USER --mysql-password=$DB_PASSWORD \
         --mysql-db=$DB_NAME \
         --threads=$NUM_THREADS \
         --events=$TOTAL_EVENTS \
         --time=120 \
         --report-interval=10 \
         run