#!/bin/bash

set -e

readonly REPO_PATH=github.com/ucloud/redis-cluster-operator

if [[ -z ${STORAGECLASSNAME} ]]; then
    echo "env STORAGECLASSNAME not set"
    exit 1
fi

if [[ -z ${GINKGO_SKIP} ]]; then
    export GINKGO_SKIP=""
fi

if [[ -z $TEST_TIMEOUT ]]; then
    echo "env $TEST_TIMEOUT not set, auto set to 60m"
    export TEST_TIMEOUT=60m
fi

echo "run e2e tests..."
echo "cd ${GOPATH}/src/${REPO_PATH} && ginkgo -v --skip=${GINKGO_SKIP} --timeout=${TEST_TIMEOUT} test/e2e/... -- --rename-command-path=${GOPATH}/src/${REPO_PATH}/test/e2e --rename-command-file=rename.conf"
cd ${GOPATH}/src/${REPO_PATH} && ginkgo -v --skip=${GINKGO_SKIP} --timeout=${TEST_TIMEOUT} test/e2e/... -- --rename-command-path=${GOPATH}/src/${REPO_PATH}/test/e2e --rename-command-file=rename.conf

