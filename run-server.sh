#!/bin/sh

if ! command >/dev/null -v socat; then
  printf "please: sudo apt-get install socat\n"
  exit 1
fi

mkdir -p logs

port="${1:-8000}"
printf "listening on port %d\n" "$port"

socat -v -v "TCP-LISTEN:$port,crlf,pktinfo,reuseaddr,fork" "SYSTEM:./server.sh"
