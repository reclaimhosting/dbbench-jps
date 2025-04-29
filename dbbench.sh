#!/bin/bash

echo 'Preparing test data...'
sysbench oltp_read_write --tables=10 --table-size=100000 --mysql-db=test_db --mysql-user=testuser --mysql-password=testpass --mysql-host=localhost prepare
echo 'Running benchmark...'
sysbench oltp_read_write --tables=10 --table-size=100000 --mysql-db=test_db --mysql-user=testuser --mysql-password=testpass --mysql-host=localhost --time=60 --threads=4 --report-interval=10 run
echo 'Cleaning up test data...'
sysbench oltp_read_write --tables=10 --table-size=100000 --mysql-db=test_db --mysql-user=testuser --mysql-password=testpass --mysql-host=localhost cleanup
