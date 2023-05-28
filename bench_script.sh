echo "DROP TABLE IF EXISTS tbl1" | ./clickhouse-client
echo "DROP TABLE IF EXISTS tbl2" | ./clickhouse-client
echo "CREATE TABLE tbl1 (x String) ENGINE = Memory" | ./clickhouse-client
echo "CREATE TABLE tbl2 (x String) ENGINE = Memory" | ./clickhouse-client

echo "INSERT INTO tbl1 SELECT randomString(800) FROM numbers(1000000)" | ./clickhouse-client
echo "INSERT INTO tbl2 (x) SELECT x FROM tbl1 ORDER BY rand() LIMIT 10000" | ./clickhouse-client

echo "SELECT trainEntropyLearnedHash(x, 'id_perf_test') FROM tbl2" | ./clickhouse-client > /dev/null

echo "SELECT entropyLearnedHash(x, 'id_perf_test') FROM tbl1" | ./clickhouse-benchmark -i 10 --delay=0
echo "SELECT cityHash64(x, 'id_perf_test') FROM tbl1" | ./clickhouse-benchmark -i 10 --delay=0
