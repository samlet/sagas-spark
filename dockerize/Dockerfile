FROM jupyter/all-spark-notebook:87210526f381
# 87210526f381 has spark version 2.4

USER root

RUN apt-get -y update && \
    apt-get install --no-install-recommends -y swig && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

RUN pip install jupyter_contrib_nbextensions  && \
    pip install jupyter_nbextensions_configurator && \
    fix-permissions /home/$NB_USER

RUN pip install kafka-python redis && \
    fix-permissions /home/$NB_USER

RUN jupyter contrib nbextension install --user && \
    jupyter nbextensions_configurator enable --user

RUN jupyter nbextension enable execute_time/ExecuteTime



