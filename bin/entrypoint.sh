#!/bin/sh

case "$1" in
setup)
  while true; do
    sleep 2
    echo | nc $PGHOST 5432 && break
  done

  createdb
  echo "ALTER USER postgres WITH PASSWORD 'dbmail'" | psql
  psql < sql/postgresql/create_tables.pgsql
  ;;

*)
  dbmail-imapd -v -D -p /tmp/dbmail-imapd.pid
  ;;

esac
