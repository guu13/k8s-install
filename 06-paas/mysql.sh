docker run --name whqmysql -v /opt/mysqldata/:/var/lib/mysql -p 13306:3306 \
  -e MYSQL_ROOT_PASSWORD=woshizhu -e TZ=Asia/Shanghai -e allowPublicKeyRetrieval=true -d registry.cn-hangzhou.aliyuncs.com/guu13/mysql:8.2


  --- 
  CREATE DATABASE xxl_job;
  CREATE USER 'xxl_job'@'%' IDENTIFIED BY 'woshizhu';
  GRANT ALL PRIVILEGES ON xxl_job.* TO 'xxl_job'@'%';
  FLUSH PRIVILEGES;

  ### Public Key Retrieval is not allowed
  GRANT ENCRYPTION_KEY_RETRIEVAL ON xxl_job.* TO 'xxl_job'@'%';
  FLUSH PRIVILEGES;