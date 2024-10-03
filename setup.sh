#!/bin/bash

set -euo pipefail

OPERATOR_VERSION=2.0.1
SPARK_VERSION=3.5.2

IMAGES=(
    "kubeflow/spark-operator:${OPERATOR_VERSION}"
    "spark:${SPARK_VERSION}"
)

# Create a Kind cluster if it doesn't exist
if ! kind get clusters | grep -q "^spark$"; then
    kind create cluster --wait=1m --name spark
fi

# Pre-load images to the cluster
for IMAGE in ${IMAGES[@]}; do
    if ! docker image inspect $IMAGE > /dev/null; then
        docker pull $IMAGE
    fi
    kind load docker-image $IMAGE --name spark
done

# Download the Helm chart locally
if [ ! -d ./spark-operator ]; then
    helm pull --untar \
        --repo https://kubeflow.github.io/spark-operator \
        --version v${OPERATOR_VERSION} \
        spark-operator
    rm -r spark-operator-${OPERATOR_VERSION}.tgz
fi

# Install the operator
helm upgrade --install \
    spark-operator ./spark-operator \
    -n spark-operator --create-namespace
