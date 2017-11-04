# -*- coding: utf-8 -*-
"""
Created on Sun Oct 15 19:36:37 2017

@author: wu
"""

#! /usr/bin/env python



# Convert a bunch of pdfs to pngs, useful for latexing and matlab output of png files.

# Note that Ghostscript and ImageMagick are needed for this to work, when installing ImageMagick on Windows be sure to select legacy applications (convert)
import os

def main():
    dir_list =  os.listdir('.')
    for full_file_name in dir_list:
        base_name, extension = os.path.splitext(full_file_name)
        if extension == '.pdf': # then .pdf file --> convert to image!
            cmd_str = ' '.join(['convert',
                                '-density 400',
                                full_file_name,
                                '-flatten',
                                '-resize 75%',
                                base_name + '.png'])
            print(cmd_str)  # echo command to terminal
            os.system(cmd_str)  # execute command

if __name__ == '__main__':
    main()