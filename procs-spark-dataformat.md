# procs-spark-dataformat.md
⊕ [databricks/spark-xml: XML data source for Spark SQL and DataFrames](https://github.com/databricks/spark-xml)

## xml
Import com.databricks.spark.xml._ to get implicits that add the .xml(...) method to DataFrame. You can also use .format("xml") and .load(...).

```scala
import org.apache.spark.sql.SparkSession
import com.databricks.spark.xml._

val spark = SparkSession.builder.getOrCreate()
val df = spark.read
  .option("rowTag", "book")
  .xml("books.xml")

val selectedData = df.select("author", "_id")
selectedData.write
  .option("rootTag", "books")
  .option("rowTag", "book")
  .xml("newbooks.xml")
```
