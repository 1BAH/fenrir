#! /usr/bin/env loki

##########################################################################
loki-prog "eq"

(
    loki-assert-eq 0 0 &> /dev/null
) || {
    echo "Error <$?>: 0 == 0"
    exit 99
}

(
    loki-assert-eq 0 1 &> /dev/null
) && {
    echo "Error <$?>: 0 != 1"
    exit 99
}

loki-gorp
##########################################################################
loki-prog "neq"

(
    loki-assert-neq 0 0 &> /dev/null
) && {
    echo "Error <$?>: 0 == 0"
    exit 99
}

(
    loki-assert-neq 0 1 &> /dev/null
) || {
    echo "Error <$?>: 0 != 1"
    exit 99
}

loki-gorp
##########################################################################
loki-prog "regeq"

(
    loki-assert-regeq "^.*er.*$" "qwertyu" &> /dev/null
) || {
    echo "Error <$?>: qwertyu =~ ^.*er.*$"
    exit 99
}

(
    loki-assert-regeq "^.*еt.*$" "qwertyu" &> /dev/null
) && {
    echo "Error <$?>: qwertyu !=~ ^.*et.*$"
    exit 99
}

loki-gorp
##########################################################################
loki-prog "rnegeq"

(
    loki-assert-rnegeq "^.*er.*$" "qwertyu" &> /dev/null
) && {
    echo "Error <$?>: qwertyu =~ ^.*er.*$"
    exit 99
}

(
    loki-assert-rnegeq "^.*et.*$" "qwertyu" &> /dev/null
) || {
    echo "Error <$?>: qwertyu !=~ ^.*et.*$"
    exit 99
}

loki-gorp
