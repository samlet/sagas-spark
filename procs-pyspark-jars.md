## procs-pyspark-jars.md
⊕ [python 3.x - Adding custom jars to pyspark in jupyter notebook - Stack Overflow](https://stackoverflow.com/questions/35946868/adding-custom-jars-to-pyspark-in-jupyter-notebook)
⊕ [[Spark Core] Spark 使用第三方 Jar 包的方式 - 山间一棵松 - 博客园](https://www.cnblogs.com/share23/p/9768308.html)
    方式一: 将第三方 Jar 包分发到所有的 spark/jars 目录下
    方式二: 将第三方 Jar 打散，和我们自己的 Jar 包打到一起; 类似的例子可以参考在Spark集群上运行程序中的打包部分
    方式三: 在spark-submit命令中，通过 --jars 指定使用的第三方Jar包

## kafka
I've managed to get it working from within the jupyter notebook which is running form the all-spark container.

I start a python3 notebook in jupyterhub and overwrite the PYSPARK_SUBMIT_ARGS flag as shown below. The Kafka consumer library was downloaded from the maven repository and put in my home directory /home/jovyan:

```python
import os
os.environ['PYSPARK_SUBMIT_ARGS'] = 
  '--jars /home/jovyan/spark-streaming-kafka-assembly_2.10-1.6.1.jar pyspark-shell'

import pyspark
from pyspark.streaming.kafka import KafkaUtils
from pyspark.streaming import StreamingContext

sc = pyspark.SparkContext()
ssc = StreamingContext(sc,1)

broker = "<my_broker_ip>"
directKafkaStream = KafkaUtils.createDirectStream(ssc, ["test1"],
                        {"metadata.broker.list": broker})
directKafkaStream.pprint()
ssc.start()
```
Note: Don't forget the pyspark-shell in the environment variables!

Extension: If you want to include code from spark-packages you can use the --packages flag instead. An example on how to do this in the all-spark-notebook can be found here: https://gist.github.com/parente/c95fdaba5a9a066efaab

Just want to say that broker should be of format like: "localhost:9092"

## csv with --packages
⊕ [Use spark-csv from Jupyter Notebook](https://gist.github.com/parente/c95fdaba5a9a066efaab)

```python
import os

os.environ['PYSPARK_SUBMIT_ARGS'] = '--packages com.databricks:spark-csv_2.10:1.3.0 pyspark-shell'

import pyspark
sc = pyspark.SparkContext()
from pyspark.sql import SQLContext
sqlContext = SQLContext(sc)
# df = sqlContext.load(source="com.databricks.spark.csv", header='true', inferSchema='true', path='cars.csv')
df = sqlContext.read.format('com.databricks.spark.csv').options(header='true').load('cars.csv')
df.show()
```

⊕ [python - SQLContext object has no attribute read while reading csv in pyspark - Stack Overflow](https://stackoverflow.com/questions/32967805/sqlcontext-object-has-no-attribute-read-while-reading-csv-in-pyspark)

```python
from pyspark.sql import SQLContext
sqlContext = SQLContext(sc)
df = sqlContext.read.format('com.databricks.spark.csv').options(header='true').load('data.csv')

```

## extensions
+ jupyter_contrib_nbextensions
    jcloud/assets/langs/procs-jupyter-extensions.md

## mysql
⊕ [How to work with MySQL and Apache Spark? - Stack Overflow](https://stackoverflow.com/questions/27718382/how-to-work-with-mysql-and-apache-spark)
⊕ [Spark SQL: JdbcRDD | | Infoobjects](http://www.infoobjects.com/2014/11/10/spark-sql-jdbcrdd/)

```scala
// spark-shell --jars /mnt/resource/lokeshtest/guava-12.0.1.jar,/mnt/resource/lokeshtest/hadoop-aws-2.6.0.jar,/mnt/resource/lokeshtest/aws-java-sdk-1.7.3.jar,/mnt/resource/lokeshtest/mysql-connector-java-5.1.38/mysql-connector-java-5.1.38/mysql-connector-java-5.1.38-bin.jar --packages com.databricks:spark-csv_2.10:1.2.0

%AddDeps mysql mysql-connector-java 5.1.47 --transitive 

import org.apache.spark.sql.SQLContext

// val sqlcontext = new org.apache.spark.sql.SQLContext(sc)
val sqlcontext = SparkSession.builder.getOrCreate()

val dataframe_mysql = sqlcontext.read.format("jdbc").option("url", "jdbc:mysql://127.0.0.1:4000/ofbiz").option("driver", "com.mysql.jdbc.Driver").option("dbtable", "PERSON").option("user", "ofbiz").option("password", "ofbiz").load()

// dataframe_mysql.show()
%%dataframe --limit=10
dataframe_mysql
```


