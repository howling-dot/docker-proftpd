#!/bin/bash

if [ -z "$USERS" ]; then
  USERS="ftp|alpineftp"
fi

for i in $USERS ; do
    NAME=$(echo $i | cut -d'|' -f1)
    PASS=$(echo $i | cut -d'|' -f2)
  FOLDER=$(echo $i | cut -d'|' -f3)

  if [ -z "$FOLDER" ]; then
    FOLDER="/FTP/$NAME"
  fi


  echo -e "$PASS\n$PASS" | adduser --home $FOLDER $NAME
  #mkdir -p $FOLDER
  chown $NAME:$NAME $FOLDER
  unset NAME PASS FOLDER
done

if [ -n "$MASQADDR" ]; then
	sed -i "s/# MasqueradeAddress/MasqueradeAddress $MASQADDR/" /etc/proftpd/proftpd.conf
fi

exec "$@"
