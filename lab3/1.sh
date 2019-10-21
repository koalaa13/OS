#!/bin/bash
ps aux | sed 1d | tr -s " " | cut -d " " -f 2,11 | tr " " ":"
