# procs-saprk-jupyter.md
⊕ [Image Specifics — docker-stacks latest documentation](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/specifics.html)
    The jupyter/pyspark-notebook and jupyter/all-spark-notebook images support the use of Apache Spark in Python, R, and Scala notebooks. The following sections provide some examples of how to get started using them.

⊕ [docker-stacks/all-spark-notebook at master · jupyter/docker-stacks](https://github.com/jupyter/docker-stacks/tree/master/all-spark-notebook)

⊕ [alexarchambault/ammonite-spark: Run spark calculations from Ammonite](https://github.com/alexarchambault/ammonite-spark)

⊕ [Machine Learning with Jupyter using Scala, Spark and Python: The Setup](https://medium.com/@faizanahemad/machine-learning-with-jupyter-using-scala-spark-and-python-the-setup-62d05b0c7f56)
    为何选择Apache Spark？为什么不坚持使用python或R？ 那么最大的原因是水平缩放。使用R或python（scikit + panda），您只能使用一台机器及其内存。因为8-100 GB的数据集是可管理的，但......
    如果您有Terabytes的数据集怎么办？如果您需要分析数据，该怎么办？如果您的ML模型在生产中不断学习怎么办？ 
    这就是Spark闪耀的地方。它允许您通过向群集添加更多计算机来进行扩展，就像hadoop一样。此外还有失败和弹性。您也可以在一台机器上进行本地开发，最后将相同的代码部署到您的spark生产集群。

## start
⊕ [How to set up PySpark for your Jupyter notebook | Opensource.com](https://opensource.com/article/18/11/pyspark-jupyter-notebook)

+ scala: workspace/toree.sh
    + notebook/procs-toree-local.ipynb
+ python: workspace/pyspark.sh
    + notebook/procs-simple.ipynb

1. pyspark只需要安装py4j, 不需要安装pyspark, 因为在spark运行环境里已经包含了, 需要设置环境变量.
    But wait… where did I call something like pip install pyspark?
    I didn't. PySpark is bundled with the Spark download package and works by setting environment variables and bindings properly. So you are all set to go now!

2. scala在jupyter上的执行环境安装见: procs-toree.md

## start with scala
```scala
val spark = SparkSession.builder.appName("Simple Application").getOrCreate()
// For implicit conversions from RDDs to DataFrames
import spark.implicits._
import org.apache.spark.sql.types._
import org.apache.spark.sql._

val prefix="../../data"
// Create an RDD
val peopleRDD = spark.sparkContext.textFile(prefix+"/resources/people.txt")

...

val df = spark.read.json(prefix+"/resources/people.json")
// Displays the content of the DataFrame to stdout
df.show()
```

## start with python
```python
from pyspark.sql import SparkSession

spark = SparkSession \
    .builder \
    .appName("Python Spark SQL basic example") \
    .config("spark.some.config.option", "some-value") \
    .getOrCreate()

# Import data types
from pyspark.sql.types import *

sc = spark.sparkContext

# Load a text file and convert each line to a Row.
lines = sc.textFile("../data/resources/people.txt")

...    
```

## in intellij
+ 如果不是用submit提交任务, 则需要加入如下的config:

```scala
    val spark = SparkSession
      .builder
      .appName("StructuredNetworkWordCount")
      .config("spark.master", "local")
      .getOrCreate()
```

      


