
# set the path and line to input
vinfile = "C:/01-MyLocalFiles/python_code/output.txt"
vinput = "THIS IS A TEST IN ALL CAPS!!!\n"

# open the file into the contents variable
f = open(vinfile, "r")
contents = f.readlines()
f.close()

# set line to input and what to input
contents.insert(8, vinput)

# open the file for writing and combine the input line and the rest of the file
f = open(vinfile, "w")
contents = "".join(contents)
f.write(contents)
f.close()