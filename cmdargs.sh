#!/bin/bash
#
# this script is going to demonstrate working with the command line arguments or parameters

# Variables
interfacenames=()
infologging=no

# Functions
function displayhelp {
	echo $(basename "$0") [-h] [-l] interfacename ...
	echo "   -h  display the command line help"
	echo "   -l  log output generated to the logfile"
}
source myfuncs

# get the interface to check from the command line
while [ $# -gt 0 ]; do
	case "$1" in
		-h )
			displayhelp
			exit
			;;
		-l )
			infologging=yes
			;;
		* )
			interfacenames+=("$1")
			;;
	esac
	shift
done

# check that we got at least one interface on the command line
if [ ${#interfacenames[@]} -eq 0 ]; then
	echoerror "You didn't specify any interface names"
	displayhelp
	exit 1
fi

# Loop through the interface name sin the array
for interface in ${interfacenames[@]}; do
	# Find the ip address for the interface if we have one
	ip=$(ip a s $interface| grep -w inet|awk '{print $2}'| sed 's,/.*,,')
	# TODO: Test if the interface name is valid
	# Check if there is an address, put an informational message where the address would be in the output
	if [ "$ip" = "" ]; then
		ip="No address configured"
		logwarning "Interface $interface has no configured IPV4 address"
	fi

	# Produce the interface information
	outputline="$interface: $ip"
	echo $outputline
	loginfo "$outputline"
done
