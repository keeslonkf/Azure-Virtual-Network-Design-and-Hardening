#!/bin/bash

#Create Directory
mkdir -p /var/backup

#Create a tar archive
tar cvvf /var/backup/home.tar.gz /home

#Moving files
sudo mv /var/backup/home.tar.gz /var/backup/home.121821.tar.gz 

#List Files
ls -lh /var/backup > /var/backup/file_report.txt

#prints free spece
free -h > /var/backup/disk_report.txt
