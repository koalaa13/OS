#!/bin/bash
cat /proc/${1}/environ | tr '\0' '\n' | wc -l
