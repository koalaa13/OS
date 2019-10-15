#!/bin/bash
find 2> /dev/null /etc -type f | xargs sha256sum 2> /dev/null > hashes
