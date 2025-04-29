#!/bin/bash

HOST="localhost"
USER="##DB_USER##"
PASSWORD="##DB_PASSWORD##"
ITERATIONS=3
CONCURRENCY="10,50,100"
QUERIES=1000

# Help
show_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -h, --host HOST         MySQL host (default: localhost)"
    echo "  -u, --user USER         MySQL user (default: root)"
    echo "  -p, --password PASS     MySQL password"
    echo "  -d, --database DB       MySQL database (default: test)"
    echo "  -i, --iterations NUM    Number of iterations (default: 3)"
    echo "  -c, --concurrency LIST  Comma-separated list of concurrencies (default: 10,50,100)"
    echo "  -q, --queries NUM       Number of queries per client (default: 1000)"
    echo "  --help                  Display this help message"
}

# Args
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--host)
            HOST="$2"
            shift 2
            ;;
        -u|--user)
            USER="$2"
            shift 2
            ;;
        -p|--password)
            PASSWORD="$2"
            shift 2
            ;;
        -d|--database)
            DATABASE="$2"
            shift 2
            ;;
        -i|--iterations)
            ITERATIONS="$2"
            shift 2
            ;;
        -c|--concurrency)
            CONCURRENCY="$2"
            shift 2
            ;;
        -q|--queries)
            QUERIES="$2"
            shift 2
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

echo "=== Benchmark ==="
echo "Host: $HOST"
echo "User: $USER"
echo "Database: $DATABASE"
echo "Iterations: $ITERATIONS"
echo "Concurrency levels: $CONCURRENCY"
echo "Queries per client: $QUERIES"
echo "========================"

# Run the benchmark
echo "Running 'SELECT * FROM information_schema.tables LIMIT 10' queries..."
echo

mysqlslap --host="$HOST" --user="$USER" --password=$PASSWORD --concurrency="$CONCURRENCY" \
    --iterations="$ITERATIONS" --number-of-queries="$QUERIES" \
    --create-schema="mysqlslap" \
    --query="SELECT * FROM information_schema.tables LIMIT 10" \
    --delimiter=";" \
    --verbose

# Run auto-generated tests (creates temp tables)
echo
echo "Running auto-generated mysqlslap tests..."
echo

mysqlslap --host="$HOST" --user="$USER" --password=$PASSWORD --concurrency="$CONCURRENCY" \
    --iterations="$ITERATIONS" --number-of-queries="$QUERIES" \
    --auto-generate-sql \
    --auto-generate-sql-load-type=mixed \
    --auto-generate-sql-add-autoincrement \
    --engine=innodb \
    --verbose
    

echo
echo "Benchmark completed."
