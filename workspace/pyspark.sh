#!/bin/bash
export SPARK_HOME="$HOME/jcloud/assets/langs/workspace/spark/spark-2.4.0-bin-hadoop2.7"
export STACK_HOME="$HOME/jcloud/assets/langs/workspace/rasa/stack"
export PYTHONPATH=$SPARK_HOME/python:$PYTHONPATH:$STACK_HOME
export PATH=$HOME/miniconda3/bin:$SPARK_HOME:$PATH:~/.local/bin:$JAVA_HOME/bin:$JAVA_HOME/jre/bin

export PYSPARK_DRIVER_PYTHON="jupyter"
export PYSPARK_DRIVER_PYTHON_OPTS="notebook"
export PYSPARK_PYTHON=python3
export SPARK_OPTS='--master=local[4]'

source activate bigdata
jupyter notebook
