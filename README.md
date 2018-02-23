drench's docker-dbmail
======================

Build the image:
```
docker-compose build
```

Initialize the database:
```
docker-compose run --rm imapd setup
```

Start an IMAP server that listens on port 5143:
```shell
docker-compose up
```

To add a user with the email `testuser@example.net` and a password of `abc123`:
```shell
docker-compose exec imapd dbmail-users -a testuser -w abc123 -s testuser@example.net
```
