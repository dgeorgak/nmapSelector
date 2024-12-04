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
    # ports=$(nmap -p- --min-rate=1000 -T4 $rhost | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//)  
    ports=$(nmap $rhost | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//)
    nmap $rhost -p$ports -A
    ;;
  *)
    echo "Invalid mode: $mode"
    exit 1
    ;;
esac