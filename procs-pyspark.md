# procs-pyspark.md
⊕ [为什么Pyspark接管Scala？ - 博客 - 分析，SAS，Excel，SPSS培训博客 - Analytixlabs](https://www.analytixlabs.co.in/blog/2018/02/27/pyspark-taking-scala/)
    用于Apache Spark的Scala和Python: 这两种编程语言都很简单，为程序员提供了大量的工作效率。大多数数据科学家选择为Apache Spark学习这两种语言。但是，您会听到大多数数据科学家通过Python为Apache Spark选择Scala。主要原因是Scala提供更快的速度。它碰巧比Python快十倍。更多的理由是： Scala有助于处理大数据系统复杂多样的基础架构。这种复杂的系统需要强大的语言，而Scala非常适合希望编写高效代码行的程序员。

    Python附带了几个与机器学习和自然语言处理相关的库。这有助于数据分析，并且还具有非常成熟和经过时间考验的统计数据。例如，numpy，pandas，scikit-learn，seaborn和matplotlib。
    Python优先于Scala用于Apache Spark的一个主要原因是后者缺少与Python不同的适当的数据科学库和工具。缺乏可视化，而不是标记本地数据转换，Scala也没有良好的本地工具。此外，还有更简单的方法直接从Python调用R，使得Python成为Scala的更好选择。

    由于多种语法糖，大数据科学家在学习Scala时需要非常谨慎。对于程序员来说，学习Scala有时会成为一个疯狂的交易，因为Scala拥有的图书馆较少，社区也没那么有用。Scala是一种复杂的编码语言，这意味着程序员需要非常注意代码的可读性。
    所有这些最终使得Scala成为一种难以掌握的语言，特别是对于初学者或缺乏经验的程序员而言，他们从大数据开始。 除非您是高度复杂数据分析的游戏，否则Python可以很好地处理简单到中等复杂的数据分析。即便如此，这对你来说也很复杂。你可以随时使用Scala进行最终的Python层。

⊕ [In theory, Scala is faster than Python for Apache Spark. In practice it is not. What's going on? - Stack Overflow](https://stackoverflow.com/questions/52713466/in-theory-scala-is-faster-than-python-for-apache-spark-in-practice-it-is-not)
⊕ [Getting Started with Spark 2.3, PySpark, and Jupyter Notebook](https://medium.com/@FrissonAI/getting-started-with-spark-2-3-pyspark-and-jupyter-notebook-eb99c0a5050e)

⊕ [Running a Container — docker-stacks latest documentation](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/running.html)

```sh
docker run --rm -p 10000:8888 -v "$PWD":/home/jovyan/work jupyter/r-notebook:e5c5a7d3e52d

docker run -it --rm -p 8899:8888 \
    -v $(pwd)/notebook:/home/jovyan/notebook \
    jupyter/scipy-notebook:77e10160c7ef

docker run -it --rm -p 8899:8888 \
    -v $(pwd)/notebook:/home/jovyan/notebook \
    jupyter/pyspark-notebook:77e10160c7ef    
```

⊕ [Image Specifics — docker-stacks latest documentation](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/specifics.html)

## start
```sh
$ enter.sh jupyter/all-spark-notebook:87210526f381
$ echo $SPARK_HOME
$ $SPARK_HOME/bin/pyspark --packages com.databricks:spark-csv_2.10:1.3.0
# The jars for the packages stored in: /home/jovyan/.ivy2/jars

# 使用jupyter
cd workspace
./pyspark.sh
```

⊕ [Getting Started - Spark 2.4.0 Documentation](https://spark.apache.org/docs/latest/sql-getting-started.html)

```python
from pyspark.sql import SparkSession

spark = SparkSession \
    .builder \
    .appName("Python Spark SQL basic example") \
    .config("spark.some.config.option", "some-value") \
    .getOrCreate()
```



