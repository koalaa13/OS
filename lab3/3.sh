#!/bin/bash
ps aux | sed 1d | tr -s " " | cut -d " " -f 2,11 | grep -hE "[[:digit:]]* /sbin/.*" | cut -d " " -f 1 > 3_ans
