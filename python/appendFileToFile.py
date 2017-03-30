#
# Reads contents of zone.txt and either writes or appends them to the end of ztwo.txt
# depending on which line you choose. With the if-then-else statement(s) you can also
# filter content
#
with open("zone.txt") as fone:
    with open("ztwo.txt", "a") as ftwo:
   #with open("ztwo.txt", "w") as ftwo: #if you want to write rather than append use this
        for line in fone:
            #if "ROW" in line: #comment out if you dont need to find anything in file.
                ftwo.write(line) 
