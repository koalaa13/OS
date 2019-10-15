#!/bin/bash
grep 2> /dev/null -h -E -o -r -a '[[:alnum:]]+\@[[:alnum:]]+\.[[:alnum:]]+' /etc | tr '\n' ','  > emails.lst
truncate -s-1 emails.lst
