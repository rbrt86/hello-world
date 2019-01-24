#!/bin/sh

## v0.1 - RJdG - initial version

help () {
  echo "pingProbe script by Robert Jan de Groot"
  echo "used to ping an endpoint with a given interval"
  echo "usage:"
  echo "  -u <url>     - used url to ping"
  echo "  -s <seconds> - seconds between ping, 5 seconds by default"
  echo "  -v           - enable verbose mode"
  echo "  -h           - print this help"

}

prereq () {

  if [ -z ${url} ]; then
    echo "[ERROR] no URL specified!"
    echo ""
    help;
    exit
  fi

  if [ -z ${sleep} ]; then
    echo "setting interval to default 5 seconds"
    sleep=5
  fi

}

runPing () {
while [ 1 -eq 1 ]; do
  ## if -s is added, do not show ouptut
    if [ "${verbose}" = "true" ]; then
      output=$(curl -s $url)
    else
      output=$(curl -s -o /dev/null -w "%{http_code}" $url)
    fi
  if [ ${output} -eq 200 ]; then
    echo "."
  else
    echo "ERROR ${output}"
  fi
  sleep ${sleep}
done
}

runAll () {
  prereq;
  runPing;
}

while getopts "u:s:vh" OPTION
do
  case $OPTION in
    u)
      url=$OPTARG
      echo "url set to ${url}"
      ;;
    s)
      sleep=${OPTARG}
      echo "interval set to ${sleep} seconds"
      ;;
    v)
      verbose=true
      echo "set to VERBOSE"
      ;;
    h)
      help;
      ;;
    \?)
      help;
      ;;
  esac
done

runAll;
