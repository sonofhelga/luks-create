#!/bin/bash

clear
echo "going to figure out wich disk we are going to make a partition on."
echo ''
sleep 1
echo "press enter when ready."
read waiting

clear
sudo lsblk

echo 'which drive do we want to create the partition on?'
echo "this should be in format /dev/sdx"
read drive

clear
echo "$drive is this what you selected?"
echo ''
echo 'do not continue otherwise.'
read waiting

clear
sudo fdisk $drive

clear
lsblk

echo ""
echo "where did we make the partition at? format is /dev/sdxx"
read partition

clear
echo "so the drive is $drive and the partition is $partition?"
read waiting

clear
echo 'where did we want to mount this bad boy?'
read location

clear
echo 'one last thing, what would we want that drive to be called when its mapped?'
read name

clear 
echo 'super last chance.'
echo "we are mounting $partition a luks device named $name at location $location"

clear
echo 'going to start making changes now.'
sleep 2

sudo cryptsetup -y -v luksFormat $partition

sudo cryptsetup open --type luks $partition $name


echo "we are going to skip key creation this time around."
sleep 1

sudo mkfs.ext4 /dev/mapper/$name

sudo mount /dev/mapper/$name $location
