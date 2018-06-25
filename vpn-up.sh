#!/bin/bash

## A script to check if a connection is available to a paticular ip/host and restart the VPN connection if not available
# Should only be used if your firewall is configured to block all traffic outside your network unless through your VPN

PINGHOST='google.ca'			# Enter the desired host to ping here

ping -c 1 $PINGHOST > /dev/null		# Ping host and redirect the output to null

## Set global vars

res=$?					# Check error code from ping
VPN="CA_Toronto"			# Choose VPN to restart

if [ $res -eq 0 ]; then										# Verify that a connection to the host can be made
	echo -e "1\nNo restart required"							# and take no action
else
	echo -e "0\nRestart of $VPN is required"							# otherwise restart the VPN connection
	systemctl restart openvpn-client@$VPN.service && echo "Restart complete"
fi

exit

