#!/bin/sh
# Variables
log="./logs/server.pid"
timeout=300 # 5 minutes

# Server response
echo HTTP/1.0 200;
echo Content-Type\: text/plain;
echo;

# Log the request
start=$(date +%s);
log=$log.$start;
echo "$start\n$SOCAT_PEERADDR" > $log;
timeout $timeout cat >> $log;
date +%s >> $log
