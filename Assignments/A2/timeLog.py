# -*- coding: utf-8 -*-
"""
Created on Fri Sep  8 22:03:42 2017

@author: wu
"""

import numpy as np
import pandas as pd

# Create a workbook and add a worksheet.
#workbook = xlsxwriter.Workbook('Expenses01.xlsx')
#worksheet = workbook.add_worksheet()
filename = 'time_log.xlsx'
week1 = [
        '2 hours reading pages 13 to 22 of text ',
         '3 hours of internet research on closed loop control system examples',
         '1 hour of practicing Laplace Transform',
         ]

week2 = [
        '3 hours spent on deriving transfer functions of example systems',
         '2 hours towards practicing block-diagram reduction techniques',
         '2 hours on solving first 4 questions of assignment 1',
         ]

week3 = [
        '3 hours spent on preparing for lab',
         '2 hours towards practicing block-diagram reduction techniques',
         '2 hours on solving first 4 questions of assignment 1',
         ]
week4 = ['2 hours doing the prelab and reading textbook',
         '2 hours reviewing and creating lecture notes',
         '6 hours solving questions of assignment 1']
pd.set_option('display.max_colwidth', -1)                         
df = pd.DataFrame.from_items([('\textbf{Week of Sep 10}', week1), 
                         ('\textbf{Week of Sep 17}', week2),
                         ('\textbf{Week of Sep 24}', week3),
                         ('\textbf{Week of Oct 1}', week4) ])
#df = df.transpose()
# Create a Pandas Excel writer using XlsxWriter as the engine.
# Convert the dataframe to an XlsxWriter Excel object.

writer = pd.ExcelWriter(filename, engine='xlsxwriter')
#Without Transposing
#df.to_excel(writer, sheet_name='Sheet1',index=False,startrow =1,startcol=1)
# Close the Pandas Excel writer and output the Excel file.
df.to_excel(writer,sheet_name='Sheet1',index=True,header=False,startrow =1,startcol=1)
writer.save()

# file-output.py
f = open('helloworld.txt','w')
f.write(df.to_latex(index=False,header=True,bold_rows=True,column_format='LLLL'))
f.close()
