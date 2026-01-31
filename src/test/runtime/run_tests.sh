#! /usr/bin/env bash

FENRIR_TEST_DIR="/tmp/fenrir_test"
FENRIR_TEST_DEBUG=${FENRIR_TEST_DEBUG:-"-v"}

export FENRIR_TEST_DIR
export FENRIR_TEST_DEBUG

if ! ./setup; then
    exit 1
fi

./runner
./teardown