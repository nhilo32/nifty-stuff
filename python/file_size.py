import os


def get_size(start_path = '.'):
    total_size = 0
    for dirpath, dirnames, filenames in os.walk(start_path):
        for f in filenames:
            fp = os.path.join(dirpath, f)
            total_size += os.path.getsize(fp)
    return total_size


def make_readable(readnum = 0):
	if readnum < 1024:
		calcsize = readnum
		output = str(calcsize) + ' bytes'
	elif 1024 <= readnum < 1048576:
		calcsize = round(readnum / 1024, 2)
		output = str(calcsize) + ' kb'
	elif 1048576 <= readnum < 1073741824:
		calcsize = round((readnum / 1024) / 1024, 2)
		output = str(calcsize) + ' mb'
	elif 1073741824 <= readnum:
		calcsize = round(((readnum / 1024) / 1024) / 1024, 2)
		output = str(calcsize) + ' gb'
	else:
		calcsize = 0
		output = 'something went wrong'
	return output


mypath = 'C:/oracle/'
for f in os.listdir(mypath):
	printout = make_readable(get_size(mypath + f))
	print(printout, mypath + f)
