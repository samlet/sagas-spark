#!/bin/bash
docker run -it --rm -p 8899:8888 \
    -v $(pwd)/notebook:/home/jovyan/notebook \
    jupyter/pyspark-notebook:77e10160c7ef
