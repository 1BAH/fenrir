#! /bin/bash

test_env_dir=$(cat TEST_ENV_DIR)

log info -v "..getroot Tests.."

##########################################################################

log info -v "Testcase 1"

if ! assert eq "$(getroot)" "$test_env_dir/root"; then
    exit 1
fi

##########################################################################

log info -v "Testcase 2"

tmp=$(mktemp)

cat "$test_env_dir/etc/fenrir/main.json" > TMP_COPY

jq --arg dir "trie" '.root = $dir' "$test_env_dir/etc/fenrir/main.json" > "$tmp"
cat "$tmp" > "$test_env_dir/etc/fenrir/main.json"

if ! assert eq "$(getroot)" "trie"; then
    exit 1
fi

cat TMP_COPY > "$test_env_dir/etc/fenrir/main.json"

##########################################################################
