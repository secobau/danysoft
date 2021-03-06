#!/bin/sh -x

set -e;

mgmt=192.168.x.x/32;

dc=169.254.169.254/32;
dcnet=169.254.169.0/24;
google="8.8.8.8/32 8.8.4.4/32";
localnet=127.0.0.0/8;
me=$(ip route|awk '{print $9}');
mynet=$(ip route|awk '/link/{print $1}');

service_net="$mgmt";
service_ports="22";
service_proto="tcp";

routing=0;

source firewall.functions;

flush_all;
accept_all_if_stop;
enable_routing_policy;
enable_firewall_policy;
allow_local;
google_icmp;
allow_service;
allow_standard_traffic;
log_everything;
drop_everything;

#systemctl restart docker;
