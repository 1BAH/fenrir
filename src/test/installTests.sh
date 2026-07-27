#! /usr/bin/env loki

function normalise_version {
    echo "${1%+*}"
}

##########################################################################

# DO NOT MAKE IT AUTOLOADABLE!
version="2026.0"

year=$(date +%Y)

loki-prog "fenrir version"

loki-assert-eq "$version" "$(normalise_version "`fenrir version`")"

loki-gorp

loki-prog "fenrir info"

loki-assert-regeq ".*fenrir $version(\+.*)?, $year.*" "$(fenrir info)"

loki-gorp

##########################################################################
