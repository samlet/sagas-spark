# procs-toree.md
⊕ [Machine Learning with Jupyter using Scala, Spark and Python: The Setup](https://medium.com/@faizanahemad/machine-learning-with-jupyter-using-scala-spark-and-python-the-setup-62d05b0c7f56)
⊕ [Quick Start](https://toree.apache.org/docs/current/user/quick-start/)
    ⊕ [Installation](https://toree.apache.org/docs/current/user/installation/)
⊕ [incubator-toree/magic-tutorial.ipynb at master · apache/incubator-toree](https://github.com/apache/incubator-toree/blob/master/etc/examples/notebooks/magic-tutorial.ipynb)
    Magics are special "functions" which enable features or execute some special code. Magics can receive input arguments when they are invoked. There are two types of magics: cell magics and line magics. Magics invocations are not case sensitive.

⊕ [FAQ](https://toree.incubator.apache.org/docs/current/user/faq/)
    Jars are added through the AddJar magic. You simply need to supply an URL for the jar to be added.
        %AddJar http://myproject.com/myproject/my.jar
    Dependencies stored in repositories can be added through the AddDeps magic. An example usage would be:
        %AddDeps my.company artifact-id version
    + https://github.com/apache/incubator-toree/blob/master/etc/examples/notebooks/magic-tutorial.ipynb

## start on macos (ok)
```sh
tar xvzf ~/tools/spark/spark-2.4.0-bin-hadoop2.7.tgz
# set SPARK_HOME to the folder
# ..

$ using bigdata
$ jupyter kernelspec list
$ pip install -U toree
$ jupyter toree install --spark_home=$SPARK_HOME
# 如果有权限问题则执行:
# $ sudo chown xiaofeiwu /usr/local/share/jupyter/kernels
# $ jupyter toree install --spark_home=$SPARK_HOME

$ jupyter kernelspec list

# The first is at install time with the --spark_opts command line option.
$ jupyter toree install --spark_opts='--master=local[4]'

# The second option is configured at run time through the SPARK_OPTS environment variable.
# 启动
$ SPARK_OPTS='--master=local[4]' jupyter notebook
```
+ 创建一个'apache toree scala'的notebook:

```scala
val rdd = sc.parallelize(0 to 999)
rdd.takeSample(false, 5)
```
+ 选项
    --jar-dir    directory where user added jars are

## add deps
```scala
%AddDeps org.joda joda-money 0.11 --transitive --trace --verbose

Marking org.joda:joda-money:0.11 for download
Preparing to fetch from:
-> file:/tmp/toree_add_deps5662724810625125387/
-> https://repo1.maven.org/maven2
=> 1 (): Downloading https://repo1.maven.org/maven2/org/joda/joda-money/0.11/joda-money-0.11.pom.sha1
```

## magic
⊕ [incubator-toree/magic-tutorial.ipynb at master · apache/incubator-toree](https://github.com/apache/incubator-toree/blob/master/etc/examples/notebooks/magic-tutorial.ipynb)

```scala
%%dataframe --limit=3
df

val sqlc = spark
import sqlc.implicits._
case class Record(key: String, value: Int)
val df = sc.parallelize(1 to 10).map(x => Record(x.toString, x)).toDF()
df.registerTempTable("MYTABLE")

%%SQL
SELECT * FROM MYTABLE WHERE value >= 6

%AddDeps org.joda joda-money 0.11 --transitive --trace --verbose
%AddJar https://repo1.maven.org/maven2/org/lwjgl/lwjgl/3.0.0b/lwjgl-3.0.0b.jar

%Truncation on
(1 to 200)
// Output WILL be truncated.

// The LsMagic is a magic to list all the available magics.
%LsMagic
```



