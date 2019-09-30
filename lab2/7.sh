#!/bin/bash
man bash | grep -hEo '[[:alpha:]]{4}[[:alpha:]]*' | sort -f | uniq -ci | sort -n | tail -n 3
