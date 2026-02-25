#! /usr/bin/env loki

##########################################################################


loki-prog "loki-get-out"

echo IN > "${OUT_FILE}"

loki-assert-eq "IN" "$(loki-get-out)"

loki-gorp

loki-prog "loki-get-err"

echo IN > "${ERR_FILE}"

loki-assert-eq "IN" "$(loki-get-err)"

loki-gorp

##########################################################################

loki-prog "Stdout capture"

(
    lokiw echo IN
)

loki-assert-eq 0 $?
loki-assert-eq "IN" "$(loki-get-out)"
loki-assert-eq ""   "$(loki-get-err)"

loki-gorp

loki-prog "Stderr capture"

(
    lokiw -u "echo IN >&2"
)

loki-assert-eq 0 $?
loki-assert-eq ""   "$(loki-get-out)"
loki-assert-eq "IN" "$(loki-get-err)"

loki-gorp

##########################################################################

loki-prog "Return code propagation"

(
    lokiw exit 2
)
loki-assert-eq 2 $?

(
    lokiw exit 0
)
loki-assert-eq 0 $?

(
    lokiw exit 255
)
loki-assert-eq 255 $?

loki-gorp

##########################################################################

loki-prog "Input redirection"

echo -e "line1\nline2" | lokiw wc -l
loki-assert-eq 2 "$(loki-get-out)"

loki-gorp

##########################################################################

loki-prog "Unsafe mode for pipelines"

lokiw -u "echo -e 'we\nqwe' | wc -l | grep 2"
loki-assert-eq 2 "$(loki-get-out)"

loki-gorp

##########################################################################

loki-prog "Exit mode"

function get_ecode {
    return "$1"
}

(
    lokiw -e get_ecode 0
    exit 77
)
loki-assert-eq 77 $?

(
    lokiw -e get_ecode 33 &> /dev/null
    exit 77
)
loki-assert-neq 77 $?

(
    lokiw -e -u "echo -e 'we\nqwe' | wc -l | grep 2"
    exit 77
)
loki-assert-eq 77 $?

(
    lokiw -e -u "echo -e 'we\nqwe' | wc -l | grep -v 2" &> /dev/null
    exit 77
)
loki-assert-neq 77 $?

loki-gorp
