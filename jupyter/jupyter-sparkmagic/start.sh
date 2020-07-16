#!/bin/bash
echo "Start a Docker image with Podman containing following packages:" 
echo "- Miniconda3 (with data science python packages"
echo "- Jupyter Server and"
echo "- SparkMagic and PySpark configured for Apache Spark Cluster connecting via Apache Livy"

podman run -i -t --rm -p 8888:8888 \
-v ./notebooks:/opt/notebooks/own:Z \
-v ./config.json:/root/.sparkmagic/config.json:Z,ro \
--name sparkmagic docker.io/continuumio/miniconda3:latest \
/bin/bash -c "
/opt/conda/bin/conda install sparkmagic -y --quiet && 
/opt/conda/bin/conda install jupyter -y --quiet && 
/opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser --allow-root"
