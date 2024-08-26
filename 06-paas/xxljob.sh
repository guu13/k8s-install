docker run -e PARAMS="--spring.datasource.url=jdbc:mysql://127.0.0.1:13306/xxl_job?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai" \
 -e PARAMS="--spring.datasource.username=root" -e PARAMS="--spring.datasource.password=woshizhu" \
 -p 8080:8080 -v /tmp:/data/applogs --name xxl-job-admin  -d registry.cn-hangzhou.aliyuncs.com/guu13/xxl-job:2.4.1