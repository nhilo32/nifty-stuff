import os

# this is a non recurive walk, directories (dirs) will be listed like files
print('Start of NON-recursive walk');
path = "C:/01-MyLocalFiles/python_code/"
dirs = os.listdir( path )
for file in dirs:
	if '.txt' in file:
		print(file)
print('End of NON-recursive walk');


print('\n--------------BREAK BETWEEN--------------------\n')


# this is a recurive walk and directories (dirs) will not be listed
print('Start of recursive walk');
for root, dirs, files in os.walk("."):  
    for filename in files:
        print(filename)
print('End of recursive walk');



# ... or use os.system, output to a file and read file
# os.system('ls -lh /usr/local/ > output.txt') ### linux
#os.system('powershell ls C:/01-MyLocalFiles/ > output.txt') ### windows
#file = open("output.txt", "r")
#print(file.read())
