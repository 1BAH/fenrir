#! /usr/bin/env loki

##########################################################################
loki-prog "Regular file"

file=$(fenrir-tmp)

if ! [ -f "$file" ]; then
    loki-log err "File <$file> is not regular!"
    exit 9
fi

loki-assert-eq "" "$(< "$file")" "File is not empty!"

loki-gorp
##########################################################################
loki-prog "Sequential creation"

file1=$(fenrir-tmp)
file2=$(fenrir-tmp)

loki-assert-neq "$file1" "$file2" "Filenames must differ!"
loki-assert-neq "$(stat -c '%i' "$file1")" "$(stat -c '%i' "$file2")" "Inodes must differ!"

loki-gorp
##########################################################################
loki-prog "Directory"

file=$(fenrir-tmp -d)

if ! [ -d "$file" ]; then
    loki-log err "File <$file> is not a directory!"
    exit 9
fi

loki-assert-eq "" "$(ls -A "$file")" "Directory is not empty!"

loki-gorp
##########################################################################
loki-prog "Named pipe"

file=$(fenrir-tmp -p)

if ! [ -p "$file" ]; then
    loki-log err "File <$file> is not a named pipe!"
    exit 9
fi

loki-gorp
##########################################################################
loki-prog "FNR_TMP_MAX_CAP"

fenrir gc # Clean tmp

export FNR_TMP_MAX_CAP=1

file1=$(fenrir-tmp)
file2=$(fenrir-tmp)

if [ -f "$file1" ]; then
    loki-log err "File <$file1> exists!"
    exit 9
fi

if ! [ -f "$file2" ]; then
    loki-log err "File <$file2> does not exist!"
    exit 9
fi

loki-gorp
