# procs.md
+ procs-tispark.ipynb
+ build tispark for spark 2.4: 
    * workspace/tidb/procs-tispark.md
+ build jupyter docker, add extensions/kafka/redis:
    * workspace/spark/dockerize/build-docker.sh 

## start
```sh
# tispark for spark 2.4 jar
$ cp /Users/xiaofeiwu/jcloud/assets/langs/workspace/tidb/tispark/core/target/tispark-core-2.0-SNAPSHOT-jar-with-dependencies.jar ./

# tidb
cd tispark
run

# jupyter
./run-all
# + notebook/procs-tispark.ipynb

# mysql-cli
./cli.sh
```

