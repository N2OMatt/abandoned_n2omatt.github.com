#!/usr/bin/python
import os;
import os.path;
import getopt;
import sys;
from termcolor import colored;

TAGS_DIR         = "../tags";
TAG_FRONT_MATTER = """---
layout: tagpage
tag: {tag_name}
---"""

def print_help():
    print "usage: create_tag [tag name]";
    exit(1);

def print_error(tag_name):
    fatal    = colored("[FATAL]",  "red");
    tag_name = colored(tag_name, "blue");

    m = "{} - [{}] already exists...".format(fatal, tag_name);
    print m;

    exit(1);

def main():
    if(len(sys.argv) == 1):
        print_help();

    desired_name = sys.argv[1];

    tags_list = os.listdir(TAGS_DIR);
    for tag_name in tags_list:
        tag_name = tag_name.replace("\n", "");
        if(desired_name == tag_name):
            print_error(tag_name);

    dst_dir       = os.path.join(TAGS_DIR, desired_name);
    dst_file      = os.path.join(dst_dir, "index.html");
    front_matter  = TAG_FRONT_MATTER.format(tag_name=desired_name);

    os.system("mkdir -p {}".format(dst_dir));
    os.system("echo \"{}\" > {}".format(front_matter, dst_file));


if(__name__ == "__main__"):
    main();
