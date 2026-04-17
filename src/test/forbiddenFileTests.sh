#! /usr/bin/env loki

##########################################################################

RUN_DIR=$(fenrir-tmp -d)
WI_RUN="${FENRIR_HOME}/shared/walk-inspections"

##########################################################################
loki-prog "Ignored directories"
testdir="${RUN_DIR}/1"
mkdir -p "${testdir}/.git"

echo -n HI > "${testdir}/.git/file" # Should trigger NLI but .git is skipped

pushd "${testdir}" &> /dev/null
"${WI_RUN}"
loki-assert-eq 0 $?
popd &> /dev/null

loki-gorp
##########################################################################
loki-prog "'build' directory"
testdir="${RUN_DIR}/2"
mkdir -p "${testdir}/build"

pushd "${testdir}" &> /dev/null
"${WI_RUN}"
loki-assert-neq 0 $?
popd &> /dev/null

loki-gorp
##########################################################################
loki-prog "'target' directory"
testdir="${RUN_DIR}/3"
mkdir -p "${testdir}/target"

pushd "${testdir}" &> /dev/null
"${WI_RUN}"
loki-assert-neq 0 $?
popd &> /dev/null

loki-gorp
##########################################################################
loki-prog "'.idea' directory"
testdir="${RUN_DIR}/4"
mkdir -p "${testdir}/.idea"

pushd "${testdir}" &> /dev/null
"${WI_RUN}"
loki-assert-neq 0 $?
popd &> /dev/null

loki-gorp
##########################################################################
loki-prog "'.vscode' directory"
testdir="${RUN_DIR}/5"
mkdir -p "${testdir}/.vscode"

pushd "${testdir}" &> /dev/null
"${WI_RUN}"
loki-assert-neq 0 $?
popd &> /dev/null

loki-gorp
##########################################################################
loki-prog "'.DS_Store' files"
testdir="${RUN_DIR}/6"
mkdir "${testdir}"
touch "${testdir}/.DS_Store"

pushd "${testdir}" &> /dev/null
"${WI_RUN}"
loki-assert-neq 0 $?
popd &> /dev/null

loki-gorp
##########################################################################
loki-prog "'*.iml' files"
testdir="${RUN_DIR}/7"
mkdir "${testdir}"

touch "${testdir}/a.im"

pushd "${testdir}" &> /dev/null
"${WI_RUN}"
loki-assert-eq 0 $?
popd &> /dev/null

touch "${testdir}/a.iml"

pushd "${testdir}" &> /dev/null
"${WI_RUN}"
loki-assert-neq 0 $?
popd &> /dev/null

loki-gorp
##########################################################################

