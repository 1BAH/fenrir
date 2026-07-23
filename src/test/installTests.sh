#! /usr/bin/env loki

##########################################################################

# DO NOT MAKE IT AUTOLOADABLE!
version="2026.0"

year=$(date +%Y)

loki-prog "fenrir v"

loki-assert-eq "$version" "$(fenrir v)"

loki-gorp

loki-prog "fenrir version"

loki-assert-eq "$version" "$(fenrir version)"

loki-gorp

loki-prog "fenrir i"

loki-assert-regeq ".*fenrir $version, $year.*" "$(fenrir i)"

loki-gorp

loki-prog "fenrir info"

loki-assert-regeq ".*fenrir $version, $year.*" "$(fenrir info)"

loki-gorp

##########################################################################
