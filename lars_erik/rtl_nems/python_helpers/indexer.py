#!/usr/bin/env python3
import fileinput

#edits file to partition a vector of rows/cols into muxes
i = 0
N = 0
with fileinput.FileInput('../clb_tile/cbox_clb_x0y0etest.v', inplace=True, backup='.bak') as file:
    for line in file:
        if(line.find("cfg_mux4") >= 0): 
            N = 4
            print(line, end='')            
        if(line.find("cfg_mux10") >= 0): 
            N = 10
            print(line, end='')                    
        elif(line.find("cfg_mux3") >= 0):
        	N = 3
        	print(line, end='')
        elif(line.find("rows[x:y]") >= 0): 
        	print(line.replace("rows[x:y]", "rows[" + str(i+N-1) + ":" + str(i) + "]"), end='')
        elif(line.find("cols[x:y]") >= 0): 
        	print(line.replace("cols[x:y]", "cols[" + str(i+N-1) + ":" + str(i) + "]"), end='')        
        	i = i + N
        else:
        	print(line, end='')



# i = -1
# with fileinput.FileInput('cbox_clb_x0y0wtest.v', inplace=True, backup='.bak') as file:
#     for line in file:
#         if(line.find("rows[9:0]") >= 0): 
#             i = i+1
#             print(line.replace("rows[9:0]", "rows[" + str(i*10+9) + ":" + str(10*i) + "]"), end='')
#         else:
#           print(line, end='')
# i = -1
# with fileinput.FileInput('cbox_clb_x0y0wtest.v', inplace=True, backup='.bak') as file:
#     for line in file:
#         if(line.find("cols[9:0]") >= 0): 
#             i = i+1
#             print(line.replace("cols[9:0]", "cols[" + str(i*10+9) + ":" + str(10*i) + "]"), end='')
#         else:
#           print(line, end='')
