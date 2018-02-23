#!/bin/sh

set -e

case "$1" in
  db_setup)
    createuser -U postgres dbmail &&
    createdb -E utf8 -U postgres -O dbmail dbmail
    ;;

  *)
    exec sleep 600
    ;;
esac
