# Kvicksand
A malformed http server responder that slows down http clients.
The purpose of this project is to document how well http bruteforcers handle timeouts.

An example PoC for the issue described in this [report](https://hackerone.com/reports/889160).

## Installing

Install socat:
```sudo apt-get install socat```

## Running
```
socat -v -v TCP-LISTEN:8000,crlf,reuseaddr,fork SYSTEM:"./server.sh"
```
