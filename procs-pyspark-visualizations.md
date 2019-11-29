# procs-pyspark-visualizations.md
⊕ [sparkmagic/autoviz.ipynb at master · jupyter-incubator/sparkmagic](https://github.com/jupyter-incubator/sparkmagic/blob/master/autovizwidget/examples/autoviz.ipynb)
⊕ [jupyter-incubator/sparkmagic: Jupyter magics and kernels for working with remote Spark clusters](https://github.com/jupyter-incubator/sparkmagic)
⊕ [Nigel Meakins | Introduction to Spark-Part 2:Jupyter Notebooks](http://blogs.adatis.co.uk/nigelmeakins/post/Introduction-to-Spark-Part-2Jupyter-Notebooks)

## start
```sh
pip install ipywidgets
jupyter nbextension enable --py widgetsnbextension

pip install sparkmagic
# Make sure that ipywidgets is properly installed by running
jupyter nbextension enable --py --sys-prefix widgetsnbextension 

```
```python
import pandas as pd
df = pd.DataFrame({'a': [1,2,3], 'b': [1,2,3], 'c': ["hi","hello","hey"]})

from autovizwidget.widget.utils import display_dataframe
display_dataframe(df)
```

+ spark

```python
from pyspark.sql import SparkSession
spark = SparkSession.builder.getOrCreate()

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

display_dataframe(result_pdf)
```

+ encoding
    ⊕ [sparkmagic/autoviz.ipynb at master · jupyter-incubator/sparkmagic](https://github.com/jupyter-incubator/sparkmagic/blob/master/autovizwidget/examples/autoviz.ipynb)

```python
from autovizwidget.widget.encoding import Encoding
from autovizwidget.widget.autovizwidget import AutoVizWidget

encoding = Encoding(chart_type=Encoding.chart_type_table, 
                    x='0', y='1', y_aggregation=Encoding.y_agg_min)
AutoVizWidget(result_pdf, encoding)
```



