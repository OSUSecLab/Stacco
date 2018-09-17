import difflib
import sys

fromfile = sys.argv[1]
tofile = sys.argv[2]
outputfile = sys.argv[3]
fromlines = open(fromfile, 'r').readlines()
tolines = open(tofile, 'r').readlines()
out = open(outputfile, 'w')

diff = difflib.HtmlDiff().make_file(fromlines,tolines,fromfile,tofile)

out.writelines(diff)