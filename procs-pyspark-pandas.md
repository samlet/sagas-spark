# procs-pyspark-pandas.md
⊕ [PySpark Usage Guide for Pandas with Apache Arrow - Spark 2.4.0 Documentation](https://spark.apache.org/docs/latest/sql-pyspark-pandas-with-arrow.html)
⊕ [pyspark.sql module — PySpark 2.4.0 documentation](https://spark.apache.org/docs/latest/api/python/pyspark.sql.html#pyspark.sql.functions.pandas_udf)

+ notebook/procs-pands.ipynb

## start
```sh
# 需要pyarrow > 0.8
$ pip install -U PyArrow
Successfully installed PyArrow-0.12.0
```
```python
# 预备spark-context
from pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()
```

```python
import numpy as np
import pandas as pd

# Enable Arrow-based columnar data transfers
spark.conf.set("spark.sql.execution.arrow.enabled", "true")

# Generate a Pandas DataFrame
pdf = pd.DataFrame(np.random.rand(100, 3))

# Create a Spark DataFrame from a Pandas DataFrame using Arrow
df = spark.createDataFrame(pdf)

# Convert the Spark DataFrame back to a Pandas DataFrame using Arrow
result_pdf = df.select("*").toPandas()
```

