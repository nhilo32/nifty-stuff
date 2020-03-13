#
# this is a non recurive walk, directories (dirs) will be listed like files
#

import os
path = "C:/01-MyLocalFiles/python_code/"
dirs = os.listdir( path )
for filename in dirs:
	if '.txt' in filename:
		print(filename)

#
# this is a recurive walk all directories and subdirectories (dirs)
#

import os
for root, dirs, files in os.walk("."):  
    # to list the files
    for filename in files:
        print(filename)
    # to list the directories
    for ldir in dirs:
    	print(ldir)

#
# run an OS command 
#

import os
os.system('ls - lh')
#or to see its output
os.system('ls -lh ../pathtofiles > output')
file = open("output", "r") 
print(file.read())

#
# read/write a file
#

file = open("testfile.txt","w") 
file.write("Hello World") 
file.write("This is our new text file") 
file.write("and this is another line.") 
file.close() 

file = open("testfile.txt", "r") 
# prints whole file
print(file.read())
# prints one line, in this case the third
print(file.readline(3))
# loops through the file and prints
for line in file: 
	print(line) 