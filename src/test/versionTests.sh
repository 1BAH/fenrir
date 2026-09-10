#! /usr/bin/env loki

function normalise_version {
    echo "${1%+*}"
}

##########################################################################

expected_version="2026.1.3"

src_dir=$(realpath "$(pwd)/../../main/fenrir")
props="${src_dir}/cli/fenrir.properties"

if ! [ -f "$props" ]; then
    loki-log err "Cannot found 'fenrir.properties'"
    exit 1
fi

while IFS='=' read -r key value; do
    case "$key" in
        version)
            version=$(normalise_version "$value")
        ;;
    esac
done < "$props"

loki-prog "Version is up to date with branch"

branch_version=${CI_COMMIT_BRANCH:-$(git branch --show-current)}
branch_version=$(echo "$branch_version" | grep -oP "\\d+\\.\\d+(\\.\\d+)?")
if (( $? != 0 )); then
    loki-log warn "Non-version branch: $(git branch --show-current)"
else
    loki-assert-eq "$(normalise_version "${branch_version}")" "${expected_version}"
fi

loki-gorp

loki-prog "fenrir.properties"

loki-assert-eq "$expected_version" "$version"

loki-gorp

loki-prog "installTests.sh"

loki-assert-regeq ".*version=\"${version}\".*" "$(cat "../installTests.sh")"

loki-gorp

loki-prog "README"

loki-assert-regeq ".*latest version is \`${version}\`.*" "$(cat "${src_dir}/../../../README.adoc")"

loki-gorp

loki-prog "antora.yml"

loki-assert-regeq ".*version: ${version}.*" "$(cat "${src_dir}/../../../antora.yml")"

loki-gorp

loki-prog "Packages"

loki-assert-regeq ".*Version: ${version}.*" "$(cat "${src_dir}/../../../fenrir.control")"
loki-assert-regeq ".*Version:        ${version}.*" "$(cat "${src_dir}/../../../fenrir.spec")"

loki-gorp

loki-prog "Makefile"
loki-assert-eq "${version}" "$(cat "${src_dir}/../../../Makefile" | head -n 1 | cut -f2 -d'=' | tr -d "$IFS")"
loki-gorp

##########################################################################
