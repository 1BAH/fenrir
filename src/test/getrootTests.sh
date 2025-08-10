#! /usr/bin/env bash

test_env_dir=$(cat TEST_ENV_DIR)

fenrir-log info -v "..getroot Tests.."

##########################################################################

fenrir-log info -v "Testcase 1"

if ! assert eq "$(fenrir-getroot)" "$test_env_dir/root"; then
    exit 1
fi

##########################################################################

fenrir-log info -v "Testcase 2"

tmp=$(mktemp)

cat "$test_env_dir/etc/fenrir/main.json" > TMP_COPY

jq --arg dir "trie" '.root = $dir' "$test_env_dir/etc/fenrir/main.json" > "$tmp"
cat "$tmp" > "$test_env_dir/etc/fenrir/main.json"

if ! assert eq "$(fenrir-getroot)" "trie"; then
    exit 1
fi

cat TMP_COPY > "$test_env_dir/etc/fenrir/main.json"

##########################################################################
