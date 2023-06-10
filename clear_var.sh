#!/bin/bash
#echo off

apt clean

rm /var/log/*.gz
apt autoclean
rm -rf /var/tmp/*
