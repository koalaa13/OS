@echo off
mkdir C:\LAB6
ver > C:\LAB6\ver.txt
wmic os get FreePhysicalMemory, TotalVisibleMemorySize > C:\LAB6\memory.txt
fsutil fsinfo drives > C:\LAB6\drives.txt
mkdir C:\TEST
xcopy C:\LAB6 C:\TEST /I /Y
copy C:\LAB6\ver.txt + C:\LAB6\memory.txt + C:\LAB6\drives.txt C:\TEST\info.txt /Y
rd /S /Q C:\LAB6