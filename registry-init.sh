# $1: root volume mount path
# $2: password cost
# $3: registry admin username

mkdir -p $1/registry/data
mkdir -p $1/registry/auth
htpasswd -Bc -C $2 $1/registry/auth/htpasswd $3
