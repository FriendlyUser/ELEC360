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
        '5 hours Prepared for ELEC 360 Lab and completed it',
         '3 hours of studying for quizzes',
         '1 hour creating notes',
         ]

week2 = [
        '2 hours working on lab report',
         '3 hours studying for midterm',
         '2 hours preparing for midterm',
         ]

week3 = [
        '3 hours spent on preparing for lab',
         '2 hours studying midterm solutions',
         '2 hours preparing for quizzes',
         ]
week4 = ['3 hours doing the prelab and and lab experiment',
         '2 hours reviewing for quizzes',
         '3 hours solving questions of assignment 2']
week5 = ['2 hours working on lab report',
         '5 hours solving question for assignment 2',
         '1 hour studying for quizzes']
pd.set_option('display.max_colwidth', -1)                         
df = pd.DataFrame.from_items([('Week of Oct 8', week1), 
                         ('Week of Oct 15', week2),
                         ('Week of Oct 22', week3),
                         ('Week of Nov 5', week4),
                         ('Week of Nov 12', week5),])
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
# write the cool new column style to the latex file
# it might make more sense to create a GUI that would take in entries and output them after I was done printing entries but there is no point a I will not eer time log things again after this course, but this was a cool way to use pandas.

# Note that \\ delimits \. so I can print out the entry.
f.write('\\newcolumntype{L}{>{\centering \\arraybackslash}m{3.5cm}} \n')
f.write(df.to_latex(index=False,header=True,bold_rows=True,column_format='LLLLL'))
f.close()
