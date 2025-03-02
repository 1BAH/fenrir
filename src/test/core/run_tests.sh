#! /bin/bash

if ! ./setup; then
    exit 1
fi

./runner
./teardown