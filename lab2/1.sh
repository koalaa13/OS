#!/bin/bash
grep 2> /dev/null -h -E -r -I 'ACPI' /var/log > errors.log
cat grep 2> /dev/null -hErI '/^(.+[^\\]) /' /home/koalaa13/lab2/errors.log

