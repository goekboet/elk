#!/bin/bash

set -e
set -u

if [ -z "$MONITOR_USR" ]; then
    echo "MONITOR_USR is unset. Needs to hold a valid postgres username."
    exit 1
fi

if [ -z "$MONITOR_PWD" ]; then
    echo "MONITOR_PWD is unset. Needs to hold a valid postgres password."
    exit 1
fi

export PGUSER=postgres
export PGPASSWORD=postgres
#export PGHOST=postgres

RUN_ON_MYDB="psql -X --set ON_ERROR_STOP=on"

$RUN_ON_MYDB <<SQL
CREATE ROLE ${MONITOR_USR} LOGIN PASSWORD '${MONITOR_PWD}';
CREATE DATABASE ${MONITOR_USR};
GRANT ALL PRIVILEGES ON DATABASE ${MONITOR_USR} TO ${MONITOR_USR};
GRANT pg_monitor TO ${MONITOR_USR};
SQL

if [ $? != 0 ]; then
    echo "psql failed while trying to run this sql script" 1>&2
    exit $?
fi

echo "sql script successful"
exit 0