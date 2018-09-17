import sys
import getopt

ifile = sys.argv[1]
inputfile = open(ifile,"r")
lines = inputfile.readlines()
inputfile.close()

temp_lines = []
pages = []
page_counts = []

for line in lines:
	if line[0:2] != "0x":
		continue
	page = int(line, 16)
	if page not in pages:
		pages.append(page)
		page_counts.append(1)
	else:
		index = pages.index(page)
		page_counts[index] += 1

for i in range(0, len(pages)):
	print "page: " + str(hex(pages[i])) + " counted " + str(page_counts[i])
	if page_counts[i] < 20:
		print hex(pages[i]) + " exploitable!"
