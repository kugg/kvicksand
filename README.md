# Kvicksand
A malformed http server responder that slows down http clients.
The purpose of this project is to document how well http bruteforcers handle timeouts.

An example PoC for the issue described in this [report](https://hackerone.com/reports/889160).

## Installing

Install socat:
```sudo apt-get install socat```

## Running
```
./run-server.sh
```

## Make a service kvicksand
Allow socat to bind ports without being root (solve this with docker if you want):
```
sudo setcap CAP_NET_BIND_SERVICE=+eip `which socat`
```

Create a systemd unit with this name:
```/etc/systemd/system/kvicksand.service```

Replace <your service user> with your service user, and adjust the paths in
WorkingDirectory and ExecStart if needed.

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
WorkingDirectory=/home/<your service user>/kvicksand
ExecStart=/home/<your service user>/kvicksand/run-server.sh 80
Restart=always

[Install]
WantedBy=multi-user.target
```
Start the service ```service kvicksand start``` or ```systemctl start kvicksand```

