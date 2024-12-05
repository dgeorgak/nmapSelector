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
    ports=$(nmap -Pn -p- $rhost | grep ^[0-9] | cut -d '/' -f 1 | tr '\n' ',' | sed s/,$//)  
    nmap -p$ports -A $rhost --reason --script "default,vuln,auth,safe" -oA $(echo $rhost)
    ;;
  all-ports)
    nmap -Pn -p- $rhost 
    ;;
  stealth)
    # needs script to be run as sudo because of -sS and -f
    nmap -p- -sS --open -Pn -n -f -T2 $rhost 
    ;;
  *)
    echo "Invalid mode: $mode"
    exit 1
    ;;
esac