#!/bin/bash
docker run -it --rm -p 8899:8888 --name jupyter \
    --network=tispark_default \
    -v $(pwd)/ivy2:/home/jovyan/.ivy2 \
    -v $(pwd)/notebook:/home/jovyan/notebook \
    -v $(pwd)/data:/home/jovyan/data \
    -v $(pwd)/spark-defaults.conf:/usr/local/spark/conf/spark-defaults.conf \
    -v $(pwd)/tispark-core-2.0-SNAPSHOT-jar-with-dependencies.jar:/usr/local/spark/jars/tispark.jar \
    samlet/jupyter_all:2.4
    # jupyter/all-spark-notebook:87210526f381
    
