:loop

copy /Z /Y /V C:\file_to_copy.txt Z:\copied_file.txt
timeout /T 60

goto loop