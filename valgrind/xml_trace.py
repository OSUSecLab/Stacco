import sys
import getopt
import re
from xml.dom import minidom
from xml.etree import ElementTree
from xml.etree.ElementTree import Element, SubElement


interested_obj_index = []


class fn:
    def __init__(self, name):
        self._name = name
        self._cfn = []

    def getname(self):
        return self._name

    def getcfn(self):
        return self._cfn

    def addcfn(self, cfn):
        added = False
        i = 0
        for c in self._cfn:
            # print "c->timestamp: " + str(c.gettimestamp()) + "  new->timestamp: " + str(cfn.gettimestamp())
            if c.gettimestamp() > cfn.gettimestamp():
                # print "insert cfn @" + str(i)
                self._cfn.insert(i, cfn)
                added = True
                break
            else:
                i += 1
        if not added:
            # print "append cfn @end"
            self._cfn.append(cfn)


class cfn:
    def __init__(self, name, timestamp):
        self._name = name
        self._timestamp = timestamp

    def getname(self):
        return self._name

    def gettimestamp(self):
        return self._timestamp


class tree:
    def __init__(self, name, timestamp):
        self._name = name
        self._timestamp = timestamp
        self._children = []

    def getname(self):
        return self._name

    def gettimestamp(self):
        return self._timestamp

    def getchildren(self):
        return self._children

    def addchild(self, subtree):
        self._children.append(subtree)


def create_fn(fn_lines, fn_list):
    first_line_parts = fn_lines[0].split()
    name = first_line_parts[1]
    
    tmp_fn = search_by_name(fn_list, name)
    if tmp_fn == False:
        tmp_fn = fn(name)
        fn_list.append(tmp_fn)

    i = 1
    # print "total lines " + str(len(fn_lines))
    while i  < len(fn_lines):
        line = fn_lines[i]

        if line[0:3] == "cob":
            cob_index = int(line[5:line.index(")")])
            if interested_obj_index and not (cob_index in interested_obj_index):
                i += 3 # move over cfn, timestamp
                continue
            else:
                i += 1
                continue

        if line[0:3] == "cfn":
            tmp_name = line.split()[1]
            # illegal_char_index = name.find("'")
            # if illegal_char_index != -1:
            #     list_name = list(tmp_name)
            #     list_name[illegal_char_index] = "`"
            #     tmp_name = ''.join(list_name)
            #     print tmp_name
            ts_line = fn_lines[i+1]
            tmp_timestamp = int(ts_line[ts_line.index("=")+1:])
            # print "current line " + str(i)
            # print tmp_timestamp
            tmp_cfn = cfn(tmp_name, tmp_timestamp)
            # print tmp_cfn.getname()
            tmp_fn.addcfn(tmp_cfn)
            i += 2
            continue

        i += 1
    # for c in tmp_fn.getcfn():
    #     print c.getname()
    #     print c.gettimestamp()


def create_tree(fn, timestamp, max_timestamp, fn_list):
    name = fn.getname()
    illegal_char_index = name.find("'")
    while illegal_char_index != -1:
        list_name = list(name)
        list_name[illegal_char_index] = "-"
        name = ''.join(list_name)
        illegal_char_index = name.find("'")
        # print name

    illegal_char_index = name.find("@")
    while illegal_char_index != -1:
        list_name = list(name)
        list_name[illegal_char_index] = "-"
        name = ''.join(list_name)
        illegal_char_index = name.find("@")
        # print name

    if name[0] == '0':
        name = 'f' + name
        # print name
    # print name

    root = tree(name, timestamp)
    # print fn.getname()
    next_index = 0
    cfn_list = fn.getcfn()
    for c in cfn_list:
        next_index += 1
        # print "next index in cfn_list: " + str(next_index)
        # print "c->timestamp: " + str(c.gettimestamp())
        # print "fn->timestamp: " + str(timestamp)
        # print "next_fn->timestamp: " + str(max_timestamp)
        if c.gettimestamp() > timestamp:
            # print "c.gettimestamp() > timestamp"
            if c.gettimestamp() < max_timestamp:
                # print "c.gettimestamp() < next timestamp"
                tmp_fn = search_by_name(fn_list, c.getname())
                if next_index < len(cfn_list):
                    tmp_subtree = create_tree(tmp_fn, c.gettimestamp(), 
                        min(max_timestamp, cfn_list[next_index].gettimestamp()), fn_list)
                else:
                    tmp_subtree = create_tree(tmp_fn, c.gettimestamp(), 
                        max_timestamp, fn_list)
                root.addchild(tmp_subtree)
            else:
                # print "c.gettimestamp() < next timestamp: " + str(max_timestamp - c.gettimestamp())
                # print max_timestamp
                break
    return root


def search_by_name(list, name):
    search_result = 0
    for i in list:
        if i.getname() == name:
            search_result = 1
            return i
    if search_result == 0:
        return False


def getio(argv):
    inputfile = ''
    outputfile = ''
    try:
      opts, args = getopt.getopt(argv,"hi:o:",["ifile=","ofile="])
    except getopt.GetoptError:
        print 'xml_trace.py -i <inputfile> -o <outputfile>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'xml_trace.py -i <inputfile> -o <outputfile>'
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg
        elif opt in ("-o", "--ofile"):
            outputfile = arg
    return [inputfile, outputfile]


def add_subelement(tree, element):
    for c in tree.getchildren():
        child_element = SubElement(element, c.getname())
        add_subelement(c, child_element)


def tree_to_element(root):
    top = Element(root.getname())
    add_subelement(root, top)
    return top

def xml_rough_string(elem):
    rough_string = ElementTree.tostring(elem, 'ASCII')
    return rough_string

def prettify(elem):
    #Return a pretty-printed XML string for the Element.
    rough_string = ElementTree.tostring(elem, 'ASCII')
    reparsed = minidom.parseString(rough_string)
    return reparsed.toprettyxml(indent="  ")


#_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*_*

[ifile, ofile] = getio(sys.argv[1:])
inputfile = open(ifile,"r")
lines = inputfile.readlines()
inputfile.close()
lengthlines = len(lines)

outputfile = open(ofile,"w")

function_list = []

i = 0
while i < lengthlines:
    # print "analyzing line " + str(i) + "..."
    line = lines[i]
    if line[0:2] == "ob":
        fl_index = int(line[4:line.index(")")])
        if interested_obj_index and not (fl_index in interested_obj_index):
            i += 2 # move over fn
            continue
        else:
            i += 1
            continue

    if line[0:2] == "fn":
        fn_start = i
        for j in range(i+1, lengthlines):
            if lines[j][0] == "\n":
                fn_end = j;
                break
        # print "fn_start: " + str(fn_start) + " fn_end: " + str(fn_end)
        create_fn(lines[fn_start:fn_end], function_list)
        i = j+1
        continue

    i += 1

root_fn = search_by_name(function_list, "SSL_accept")
print "building call tree: " + root_fn.getname()
tree_root = create_tree(root_fn, 0, sys.maxint, function_list)
top = tree_to_element(tree_root)
# outputfile.write(xml_rough_string(top))
outputfile.write(prettify(top))
