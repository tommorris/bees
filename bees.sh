#!/bin/bash

set -e
set -o pipefail

usage() {
  echo "Usage: $(basename "$0") [OPTIONS]" 1>&2
  echo "  -h               - help"
  echo "  -q               - quality:"
  echo "                       standard: ASCCI output (default)"
  echo "                       hd:       emoji output"
  exit 1
}

QUALITY="standard"

while getopts "q:h" opt; do
  case $opt in
    q)
      if ! [[ "$OPTARG" =~ ^(standard|hd)$ ]]; then
        usage
      fi
      QUALITY=$OPTARG
      ;;
    h)
      usage
      exit;;
    *)
      usage
      exit;;
  esac
done


print_bee() {
  X_SPACE=$(printf ' %.0s' $(seq 1 "$1"))

  if [ "$2" == "hd" ]
  then
    echo "$X_SPACE" 🐝
  else
    # Art by Hayley Jane Wakenshaw
    # https://www.asciiart.eu/animals/insects/bees
    echo "$X_SPACE    _  _"
    echo "$X_SPACE   | )/ )"
    echo "$X_SPACE\\\\ |//,' __"
    echo "$X_SPACE(\")(_)-\"()))=-"
    echo "$X_SPACE   (\\\\"
  fi
}

while true
do
  
  SPACE="$(shuf -i 1-100 -n 1)"
  print_bee "$SPACE" "$QUALITY"
  sleep 0.1
done
