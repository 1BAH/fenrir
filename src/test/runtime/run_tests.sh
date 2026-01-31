#! /usr/bin/env bash

set -e

FENRIR_TEST_DIR="/tmp/fenrir_test"
FENRIR_TEST_DEBUG=${FENRIR_TEST_DEBUG:-"-v"}

export FENRIR_TEST_DIR
export FENRIR_TEST_DEBUG

./setup

PATH=$(cat "${FENRIR_TEST_DIR}/PATH_NEW")
export PATH

./runner
./teardown