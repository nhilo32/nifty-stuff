with open("zone.txt") as fone:
    with open("ztwo.txt", "a") as ftwo:
        for line in fone:
            #if "ROW" in line: #comment out if you dont need to find anything in file.
                ftwo.write(line) 
