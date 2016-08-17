# Kabel Deutschland IPchanger
This is a proof of concept that shows it is possible to change your public Kabel Deutschland IP address on the fly (without rebooting any device at all). Use at your own risk.

## Setup

- Netgear WNDR3700v4 router...
- ...behind bridged Kabel Deutschland Hitron CVE modem

## How?

The script temporarily spoofs the MAC address of the Netgear router so that the provider thinks a new gateway was connected. Afterwards the MAC address is set back to normal resulting in a new IP.

## Usage

`./changeip.sh [gatewayip] [username] [password]`

Example:

`./changeip.sh 192.168.178.1 admin mysecret`

Output:

    Old IP: 188.191.210.163
    New IP: 188.191.206.38


## Contributions

Feel free to contribute by submitting pull requests.