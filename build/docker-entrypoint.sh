#!/usr/bin/env bash

# Exit immediately on non-zero return codes.
set -ex

# Run start command if only options given.
if [ "${1:0:1}" = '-' ]; then
  set -- usr/bin/zcashd -printtoconsole
fi

# Run boot scripts before starting the server.
if [ "$1" = 'usr/bin/zcashd' ]; then

	# Prepare the data directory.
	mkdir -p /data/.zcash

	if [ ! -f /data/.zcash/zcash.conf ]
	then
		echo "rpcuser=rpcuser" >> /data/.zcash/zcash.conf
		echo "rpcpassword=`head -c 32 /dev/urandom | base64`" >> /data/.zcash/zcash.conf
		chmod 600 /data/.zcash/zcash.conf
	fi

	chown -R zcash:zcash /data

	if [ ! -d /data/.zcash-params ]
	then
		gosu zcash zcash-fetch-params
	fi

  # Run via steam user if the command is `startserver.sh`.
  set -- gosu zcash "./$@"
fi

# Execute the command.
exec "$@"
