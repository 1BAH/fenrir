#! /usr/bin/env loki

##########################################################################

expected_version="1.0.0"

src_dir=$(realpath "$(pwd)/../../main/fenrir")
props="${src_dir}/cli/fenrir.properties"

if ! [ -f "$props" ]; then
    loki-log err "Cannot found 'fenrir.properties'"
    exit 1
fi

while IFS='=' read -r key value; do
    case "$key" in
        version)
            version=$value
        ;;
    esac
done < "$props"

loki-prog "Version is up to date"

loki-assert-eq "$expected_version" "$version"

loki-gorp

loki-prog "installTests.sh"

loki-assert-regeq ".*version=\"${version}\".*" "$(cat "../installTests.sh")"

loki-gorp

loki-prog "README"

loki-assert-regeq ".*Latest version is \`${version}\`.*" "$(cat "${src_dir}/../../../README.md")"

loki-gorp

loki-prog "antora.yml"

loki-assert-regeq ".*version: ${version}.*" "$(cat "${src_dir}/../../../antora.yml")"

loki-gorp


##########################################################################
