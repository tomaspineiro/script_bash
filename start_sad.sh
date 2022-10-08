#!/bin/bash

$PARAMETRO = $1
$MACHIN=$2
$USER=$3
$IP=$4



star_simpre(){

	mount /dev/nvme0n1p2 /var/lib/libvirt/images

	df -h

	virt-manager
}


if [$PARAMETRO = '' ] then

	star_siempre 

elif [$PARAMETRO = '-s'	] then

	start_siempre
	virsh start debian10
	ssh guest@192.168.122.3

elif [$PARAMETRO = '-n'] then 

	start_siempre
	virsh start $2
	ssh $3@$4

fi

