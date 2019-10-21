#!/bin/bash
ps aux | tail -n 1 | tr -s " " | cut -d " " -f 2
