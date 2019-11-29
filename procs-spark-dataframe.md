# procs-spark-dataframe.md
⊕ [RDD、DataFrame和DataSet的区别 - 简书](https://www.jianshu.com/p/c0181667daa0)
    RDD、DataFrame和DataSet是容易产生混淆的概念，必须对其相互之间对比，才可以知道其中异同。
    在2.X中DataFrame=DataSet[Row],其实是不知道类型。
    
    DataFrame多了数据的结构信息，即schema。RDD是分布式的Java对象的集合。DataFrame是分布式的Row对象的集合。DataFrame除了提供了比RDD更丰富的算子以外，更重要的特点是提升执行效率、减少数据读取以及执行计划的优化，比如filter下推、裁剪等。

⊕ [且谈Apache Spark的API三剑客：RDD、DataFrame和Dataset](https://www.infoq.cn/article/three-apache-spark-apis-rdds-dataframes-and-datasets)
