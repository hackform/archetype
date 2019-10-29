. ./source.sh
out=defs
rm -rf $out
mkdir -p $out

deftpl=$(find * -name 'dc.*.yaml')

for i in $deftpl; do
  echo generating: $i
  docker-compose -f $i config > $out/$i
done
