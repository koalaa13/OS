@echo off
net start > services.txt
net stop dnscache
timeout 5
net start > new_services.txt
fc services.txt new_services.txt > services_diff.txt
net start dnscaches
