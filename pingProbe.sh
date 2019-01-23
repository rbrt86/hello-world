#!/bin/sh

## v0.1 - RJdG - initial version

if [ -z $1 ]; then
  echo "<ERROR> please provide an URL to probe"
  exit
else
  url=$1
fi

if [ -z $2 ]; then
  echo "setting interval to default 5 seconds"
  sleep=5
else
  sleep=$2
fi

while [ 1 -eq 1 ]; do
  output=$(curl -s -o /dev/null -w "%{http_code}" $url)
  if [ ${output} -eq 200 ]; then
    echo "."
  else
    echo "ERROR ${output}"
  fi
  sleep ${sleep}
done
