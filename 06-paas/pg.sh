docker run --name whqpg -e POSTGRES_PASSWORD=woshizhu -e TZ=Asia/Shanghai -p 15432:5432 \
 -v /opt/pgdata:/var/lib/postgresql/data -d postgres:14


psql -h localhost -p 15432 -U postgres


create  database whq1;
CREATE USER whq1 WITH PASSWORD 'woshizhu';
GRANT ALL PRIVILEGES ON DATABASE whq1 TO whq1;

CREATE TABLE whq1(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO whq1 (name) VALUES ('whq1');


create  database whq2;
CREATE USER whq2 WITH PASSWORD 'woshizhu';
GRANT ALL PRIVILEGES ON DATABASE whq2 TO whq2;

CREATE TABLE whq2(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO whq2 (name) VALUES ('whq2');

----

apiVersion: pgv2.percona.com/v2
kind: PerconaPGRestore
metadata:
  name: pg24s3-restore-whq1
spec:
  pgCluster: pg24s3
  repoName: repo1
  options:
  - --type=time
  - --target="2022-11-30 15:12:11+03"

apiVersion: pgv2.percona.com/v2
kind: PerconaPGRestore
metadata:
  name: restore1
spec:
  pgCluster: cluster1
  repoName: repo1
  options:
  - --type=immediate
  - --set=20240628-074416F
  

sysbench --db-driver=pgsql --pgsql-host=10.211.55.11 --pgsql-port=15432 --pgsql-user=test --pgsql-password=woshizhu --pgsql-db=testdb \
 --tables=10 --table-size=1000000 /usr/share/sysbench/oltp_read_write.lua prepare


## // macos docker
sysbench --db-driver=pgsql --pgsql-host=10.211.55.11 --pgsql-port=15432 \
 --pgsql-user=test --pgsql-password=woshizhu --pgsql-db=testdb \
 --tables=10 --table-size=1000000 /usr/local/Cellar/sysbench/1.0.20_6/share/sysbench/oltp_read_write.lua prepare


sysbench --db-driver=pgsql --pgsql-host=10.211.55.11 --pgsql-user=test --pgsql-port=15432 --pgsql-password=woshizhu --pgsql-db=testdb --tables=10 --table-size=1000000 --threads=10 --time=120 /usr/local/Cellar/sysbench/1.0.20_6/share/sysbench/oltp_read_write.lua run


## // macos 二进制
sysbench --db-driver=pgsql --pgsql-host=10.211.55.11 --pgsql-port=5432 \
 --pgsql-user=test --pgsql-password=woshizhu --pgsql-db=testdb \
 --tables=10 --table-size=1000000 /usr/local/Cellar/sysbench/1.0.20_6/share/sysbench/oltp_read_write.lua prepare

sysbench --db-driver=pgsql --pgsql-host=10.211.55.11 --pgsql-user=test --pgsql-port=5432 --pgsql-password=woshizhu --pgsql-db=testdb --tables=10 --table-size=1000000 --threads=10 --time=120 /usr/local/Cellar/sysbench/1.0.20_6/share/sysbench/oltp_read_write.lua run
