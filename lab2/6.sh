#!/bin/bash
find 2> /dev/null /var/log -name '*.log' -exec cat 2> /dev/null {} + | wc -l 
