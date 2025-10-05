#!/bin/bash
# A very basic script that runs nmap every day using default ports and then uses ndiff to compare the results.
PORTS=21,22,23,25,53,67,68,69,80,81,110,111,123,137,138,139,143,161,162,389,443,445,465,587,631,636,873,989,990,993,995,1080,1433,1521,2049,2181,2375,2376,27017,28017,3000,3128,3306,3389,5432,5601,5900,5984,5985,5986,6000,6379,6380,6667,7001,8000,8080,8081,8086,8088,8443,8888,9000,9042,9090,9092,9200,9300,10000,10250,10255,11211,5000,50070,6443

 mkdir /opt/nmap_diff
 d=$(date +%Y-%m-%d)
 y=$(date -d yesterday +%Y-%m-%d)
 /usr/bin/nmap -T4 -p $PORTS -oX /opt/nmap_diff/scan_$d.xml -sV $1 > /dev/null 2>&1
 if [ -e /opt/nmap_diff/scan_$y.xml ]; then
/usr/bin/ndiff /opt/nmap_diff/scan_${y}.xml /opt/nmap_diff/scan_${d}.xml > /opt/nmap_diff/diff_$d.txt
fi

# Build email alerting/notification system not implemented.