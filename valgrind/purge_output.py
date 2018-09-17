import sys
import getopt
import re


interested_obj_index = []


def getio(argv):
	inputfile = ''
	outputfile = ''
	try:
	  opts, args = getopt.getopt(argv,"hi:o:",["ifile=","ofile="])
	except getopt.GetoptError:
		print 'purge_output.py -i <inputfile> -o <outputfile>'
		sys.exit(2)
	for opt, arg in opts:
		if opt == '-h':
			print 'purge_output.py -i <inputfile> -o <outputfile>'
			sys.exit()
		elif opt in ("-i", "--ifile"):
			inputfile = arg
		elif opt in ("-o", "--ofile"):
			outputfile = arg
	return [inputfile, outputfile]


def filter_lines(lines, output_lines):
	lengthlines = len(lines)
	for i in range(0,lengthlines):
		if lines[i][0:2] == "fn" or lines[i][0:3] == "cfn" or lines[i][0:2] == "ob" or lines[i][0:3] == "cob" or lines[i][0] == "\n" or lines[i][0:4] == "last":
			if (lines[i][0:2] == "ob") and i > 0 and lines[i-1][0] != "\n":
				continue
			# if (lines[i][0:2] == "fl" or lines[i][0:2] == "fi" or lines[i][0:2] == "fe") and i > 0 and lines[i-1][0] != "\n" and lines[i-1][0:2] != "ob":
				# continue
			output_lines.append(lines[i])

	return output_lines

def output_lines(lines, outputfile):
	for line in lines:
		outputfile.write(line)


[ifile, ofile] = getio(sys.argv[1:])
inputfile = open(ifile,"r")
lines = inputfile.readlines()
inputfile.close()

outputfile = open(ofile,"w")
temp_lines = []

temp_lines = filter_lines(lines, temp_lines)
lengthlines = len(temp_lines)

i = 0
while i < lengthlines:
    line = temp_lines[i]
    if line[0:2] == "ob":
        fl_index = int(line[4:line.index(")")])
        if interested_obj_index and not (fl_index in interested_obj_index):
            i += 2 # move over fn
            continue
        else:
            outputfile.write(line)
            i += 1
            continue

    if line[0:2] == "fn":
        fn_start = i
        for j in range(i+1, lengthlines):
            if temp_lines[j][0] == "\n":
                fn_end = j;
                break
        # print "fn_start: " + str(fn_start) + " fn_end: " + str(fn_end)
        output_lines(temp_lines[fn_start:fn_end], outputfile)
        outputfile.write("\n")
        i = j+1
        continue

    i += 1

