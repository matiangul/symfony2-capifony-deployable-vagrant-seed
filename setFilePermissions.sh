#! /bin/sh

if [ "$1" = "" ]; then
    user=$(whoami)
else
    user=$1
fi

if [ -n "$(getent passwd $user)" ]; then
    echo "Setting permissions for $user ..."
    setfacl -R -m u:$user:rwx  app/cache app/logs tmp web/uploads
    setfacl -dR -m u:$user:rwx  app/cache app/logs tmp web/uploads
    echo "[OK] Permissions set for user $user"
    exit 0
else
    echo "User $user not found - permissions not set"
    exit 0
fi
exit
