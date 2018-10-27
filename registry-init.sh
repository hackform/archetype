source ./source.sh
mkdir -p $LAUNCH_ROOTPATH/registry/data
mkdir -p $LAUNCH_ROOTPATH/registry/auth
htpasswd -Bc -C $REGISTRY_PASSWORD_COST $LAUNCH_ROOTPATH/registry/auth/htpasswd $REGISTRY_USERNAME
