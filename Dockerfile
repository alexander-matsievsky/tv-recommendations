FROM jupyter/all-spark-notebook:703d8b2dcb88
ENV JUPYTER_ENABLE_LAB=yes
RUN pip install altair nb-black neo4j
# See https://github.com/ipython/ipython/issues/12740.
RUN pip install jedi==0.17.2
