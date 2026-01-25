#!/bin/bash

echo "=============================="
echo "   LINUX HEALTH SNAPSHOT"
echo "=============================="
echo "Date: $(date)"
echo "Host: $(hostname)"
echo

echo "---- UPTIME ----"
uptime
echo

echo "---- DISK USAGE ----"
df -h
echo

echo "---- MEMORY USAGE ----"
free -h
echo

echo "---- TOP 5 CPU PROCESSES ----"
ps aux --sort=-%cpu | head -n 6
echo

echo "---- FAILED SERVICES ----"
systemctl --failed --no-pager
echo

echo "---- LAST 20 ERROR LOGS ----"
journalctl -p err -n 20 --no-pager
echo

echo "---- END OF THE SCRIPT ----"
