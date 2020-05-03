#!/usr/bin/env python3
#maxlen = no. of nems in block
#30 = no of NEMS per col
maxlen = 118
N = int(maxlen/30)
row = "{" + str(N) + "{cfgrows[29:0]},cfgrows[" + str(maxlen - N*30) + ":0]}"
print(row)
print("\n")

s = "{"
for i in range(25, (25+N)):
    s += "30{cfgcols[" + str(i) + "]},"
s += (str(N+1) + "{cfgcols[" + str(maxlen - N*30) + "]}")
s += "}"
print(s)