# procs-spark-sql.md
⊕ [[Spark sql]--所有函数举例(spark-2.x版本) - 余额不足 - CSDN博客](https://blog.csdn.net/high2011/article/details/79487796)
⊕ [Spark 实战，第 3 部分: 使用 Spark SQL 对结构化数据进行统计分析 - 木东的博客 - CSDN博客](https://blog.csdn.net/u010159842/article/details/53906879)

⊕ [dataframe - Spark SQL: apply aggregate functions to a list of column - Stack Overflow](https://stackoverflow.com/questions/33882894/spark-sql-apply-aggregate-functions-to-a-list-of-column)

## sql-joins
⊕ [Apache Spark SQL Joins – Adrian – Medium](https://medium.com/@adrianchang/apache-spark-sql-joins-part-1-data-inner-join-and-cross-join-7d209b368ba4)
⊕ [Dataset Join Operators · The Internals of Spark SQL](https://jaceklaskowski.gitbooks.io/mastering-spark-sql/spark-sql-joins.html)

## start
+ python: procs-aggregate.ipynb
+ scala: scala/procs-aggregate.ipynb

```scala
val df = sc.parallelize(Seq(
  (1.0, 0.3, 1.0), (1.0, 0.5, 0.0),
  (-1.0, 0.6, 0.5), (-1.0, 5.6, 0.2))
).toDF("col1", "col2", "col3")

df.groupBy($"col1").min().show

// +----+---------+---------+---------+
// |col1|min(col1)|min(col2)|min(col3)|
// +----+---------+---------+---------+
// | 1.0|      1.0|      0.3|      0.0|
// |-1.0|     -1.0|      0.6|      0.2|
// +----+---------+---------+---------+

// Optionally you can pass a list of columns which should be aggregated

df.groupBy("col1").sum("col2", "col3")
```


