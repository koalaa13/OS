#!/bin/bash
grep -h -E '(WW)' /home/koalaa13/.local/share/xorg/Xorg.0.log > full.log
sed -i 's/(WW)/Warning:/g' full.log
grep -h -E '(II)' /home/koalaa13/.local/share/xorg/Xorg.0.log >> full.log
sed -i 's/(II)/Information:/g' full.log

