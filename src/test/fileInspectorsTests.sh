#! /usr/bin/env loki

##########################################################################

RUN_DIR=$(fenrir-tmp -d)
WI_RUN="${FENRIR_HOME}/shared/walk"

##########################################################################
loki-prog "NLI"
testdir="${RUN_DIR}/1"
mkdir -p "${testdir}"


echo HI > "${testdir}/file"

"${WI_RUN}/new-line-inspector" "${testdir}/file"
loki-assert-eq 0 $?

echo -n HI > "${testdir}/file1" # Must trigger NLI
"${WI_RUN}/new-line-inspector" "${testdir}/file1"
loki-assert-neq 0 $?

loki-gorp
##########################################################################
loki-prog "HI"
testdir="${RUN_DIR}/2"
mkdir -p "${testdir}"

for ext in h hh hpp hxx H hp; do
    echo '#include <stdio.h>' > "${testdir}/test.${ext}"
    "${WI_RUN}/header-inspector" "${testdir}/test.${ext}"
    loki-assert-eq 0 $?

    echo '#include "stdio.h"' > "${testdir}/test.${ext}"
    "${WI_RUN}/header-inspector" "${testdir}/test.${ext}"
    loki-assert-eq 0 $?

    echo '#include "../stdio.h"' > "${testdir}/test.${ext}"
    "${WI_RUN}/header-inspector" "${testdir}/test.${ext}"
    loki-assert-neq 0 $?
done

for ext in "c" "cc" "cxx" "cpp" "C" "cp"; do
    echo '#include <stdio.h>' > "${testdir}/test.${ext}"
    "${WI_RUN}/header-inspector" "${testdir}/test.${ext}"
    loki-assert-eq 0 $?

    echo '#include "stdio.h"' > "${testdir}/test.${ext}"
    "${WI_RUN}/header-inspector" "${testdir}/test.${ext}"
    loki-assert-eq 0 $?

    echo '#include "../stdio.h"' > "${testdir}/test.${ext}"
    "${WI_RUN}/header-inspector" "${testdir}/test.${ext}"
    loki-assert-neq 0 $?
done

loki-gorp
##########################################################################
