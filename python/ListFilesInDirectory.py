#
# Lists all files in a directory
#

import os
for file in os.listdir("./"):
    if file.endswith(".txt"):
        print(file)
        #print(os.path.join("/mydir", file))
