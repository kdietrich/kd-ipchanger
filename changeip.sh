#!/bin/bash

gatewayip=$1
username=$2
password=$3

if [  $# -le 2 ]
then
    echo -e "Usage:\n$0 [gatewayip] [username] [password]"
    exit 1
fi

# Output old ip

ip=$(curl --silent 'https://ifconfig.co/' 2>&1)
echo "Old IP: ${ip}"

# Spoof mac address

token=$(curl --silent "http://${gatewayip}/BAS_ether.htm" --user ${username}: 2>&1 | grep -o 'timestamp=[0-9]*' | sed 's/timestamp=//g')

curl --silent "http://${gatewayip}/apply.cgi?/BAS_update.htm%20timestamp=${token}" --data 'submit_flag=ether&conflict_wanlan=&change_wan_type=1&run_test=no&ether_ipaddr=0.0.0.0&ether_subnet=0.0.0.0&ether_gateway=0.0.0.0&ether_dnsaddr1=8.8.8.8&ether_dnsaddr2=8.8.4.4&ether_dnsaddr3=&hid_mtu_value=1500&Apply=%C3%9Cbernehmen&loginreq=dhcp&system_name=WNDR3700v4&domain_name=&WANAssign=dhcp&DNSAssign=1&DAddr1=8&DAddr2=8&DAddr3=8&DAddr4=8&PDAddr1=8&PDAddr2=8&PDAddr3=4&PDAddr4=4&TDAddr1=&TDAddr2=&TDAddr3=&TDAddr4=&MACAssign=2&Spoofmac=5C%3AC4%3AA5%3A66%3A55%3A96' --user ${username}:${password} > /dev/null

sleep 3

# Renew connection

token=$(curl --silent "http://${gatewayip}/RST_conn_status.htm" --user ${username}:${password} 2>&1 | grep -o 'timestamp=[0-9]*' | sed 's/timestamp=//g')

curl --silent "http://${gatewayip}/apply.cgi?/RST_conn_status.htm%20timestamp=${token}" --data 'submit_flag=connect_status&endis_connect=3' --user ${username}:${password} > /dev/null

sleep 10

# Reset mac address

token=$(curl --silent "http://${gatewayip}/BAS_ether.htm" --user ${username}:${password} 2>&1 | grep -o 'timestamp=[0-9]*' | sed 's/timestamp=//g')

curl --silent "http://${gatewayip}/apply.cgi?/BAS_update.htm%20timestamp=${token}" --data 'submit_flag=ether&conflict_wanlan=&change_wan_type=1&run_test=no&ether_ipaddr=0.0.0.0&ether_subnet=0.0.0.0&ether_gateway=0.0.0.0&ether_dnsaddr1=8.8.8.8&ether_dnsaddr2=8.8.4.4&ether_dnsaddr3=&hid_mtu_value=1500&Apply=%C3%9Cbernehmen&loginreq=dhcp&system_name=WNDR3700v4&domain_name=&WANAssign=dhcp&DNSAssign=1&DAddr1=8&DAddr2=8&DAddr3=8&DAddr4=8&PDAddr1=8&PDAddr2=8&PDAddr3=4&PDAddr4=4&TDAddr1=&TDAddr2=&TDAddr3=&TDAddr4=&MACAssign=0' --user ${username}:${password} > /dev/null

sleep 3

# Renew connection

token=$(curl --silent "http://${gatewayip}/RST_conn_status.htm" --user ${username}:${password} 2>&1 | grep -o 'timestamp=[0-9]*' | sed 's/timestamp=//g')

curl --silent "http://${gatewayip}/apply.cgi?/RST_conn_status.htm%20timestamp=${token}" --data 'submit_flag=connect_status&endis_connect=3' --user ${username}:${password} > /dev/null

sleep 10

# Output new ip

ip=$(curl --silent 'https://ifconfig.co/' 2>&1)
echo "New IP: ${ip}"
