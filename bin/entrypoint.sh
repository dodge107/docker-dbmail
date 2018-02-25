#!/usr/bin/env bash

die() {
  >&2 echo $@
  exit 111
}

ensure_pg_envs_are_set() {
  test -z "$PGDATABASE" && die 'Please set PGDATABASE'
  test -z "$PGHOST" && die 'Please set PGHOST'
  test -z "$PGPASSWORD" && die 'Please set PGPASSWORD'
  test -z "$PGPORT" && die 'Please set PGPORT'
  test -z "$PGUSER" && die 'Please set PGUSER'
}

wait_for_port() {
  host=$1
  port=$2
  n=100

  while true; do
    sleep 2
    printf "${n} ... "
    echo | nc -v -w 1 $host $port && break
    ((n--))

    test $n -gt 0 && continue

    die "Giving up on ${host}:${port}!"
  done
}

complete_config() {
  sed -i \
    "s#dburi =#dburi = postgresql://${PGUSER}:${PGPASSWORD}@${PGHOST}:${PGPORT}/${PGDATABASE}#" \
    /usr/local/etc/dbmail.conf
}

case "$1" in
imapd)
  ensure_pg_envs_are_set
  complete_config
  exec dbmail-imapd -v -D
  ;;

setup)
  ensure_pg_envs_are_set
  wait_for_port $PGHOST $PGPORT
  exec psql < sql/postgresql/create_tables.pgsql
  ;;

*)
  exec $@
  ;;

esac
