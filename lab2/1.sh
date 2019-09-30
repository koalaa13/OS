#!/bin/bash
grep -h -E -r '^ACPI' /var/log/* > errors.log
