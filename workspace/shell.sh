#!/bin/bash
docker run -it --rm -v $(pwd)/ivy2:/home/jovyan/.ivy2 \
    -v $(pwd)/notebook:/home/jovyan/notebook \
    -v $(pwd):/app \
    jupyter/all-spark-notebook:87210526f381 bash

# $SPARK_HOME/bin/pyspark --packages com.databricks:spark-csv_2.10:1.3.0


