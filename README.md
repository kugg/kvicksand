# Kvicksand
A malformed http server responder that slows down http clients.
The purpose of this project is to document how well http bruteforcers handle timeouts.

An example PoC for the issue described in this [report](https://hackerone.com/reports/889160).

## Installing

Install socat:
```sudo apt-get install socat```
Set up permissions and dirs:
```
mkdir logs
chmod +x server.sh
```

## Running
```
socat -v -v TCP-LISTEN:8000,crlf,pktinfo,reuseaddr,fork SYSTEM:"./server.sh"
```

## Make a service kvicksand
Allow socat to bind ports without being root (solve this with docker if you want):
```
sudo setcap CAP_NET_BIND_SERVICE=+eip `which socat`
```

Create a systemd unit with this name:
```/etc/systemd/system/kvicksand.service```

Replace <your service user> with your service user and install dir path:

```
[Unit]
Description=Kvicksand service
After=network.target

[Service]
Type=simple
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=kvicksand
User=<your service user>
WorkingDirectory=/home/<your service user>/kvicksand/
ExecStart=/usr/bin/socat -v -v TCP-LISTEN:80,pktinfo,crlf,reuseaddr,fork SYSTEM:"./server.sh"
Restart=always

[Install]
WantedBy=multi-user.target
```
Start the service ```service kvicksand start``` or ```systemctl start kvicksand```

