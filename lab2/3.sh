#!/bin/bash
grep -h -E -o -r -a '[[:alnum:]]+\@[[:alnum:]]+\.[[:alnum:]]+' /etc | tr '\n' ','  > emails.lst

