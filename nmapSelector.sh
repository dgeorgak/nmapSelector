#!/bin/bash

while getopts ":m:" opt; do
  case $opt in
    m) mode="$OPTARG";;
    \?) echo "Invalid option: -$OPTARG"; exit 1;;
  esac
done

shift $((OPTIND-1))

if [ $# -ne 1 ]; then
  echo "Usage: $0 <rhost> [-m <mode>]"
  exit 1
fi

rhost=$1

case $mode in
  thorough)
    nmap -p- -A $rhost --reason --script "default,vuln,auth,safe" -oA $(echo $rhost)
    ;;
  sequencial)
    nmap $rhost
    ;;
  *)
    echo "Invalid mode: $mode"
    exit 1
    ;;
esac