import os

os.chdir(os.path.dirname(__file__))
src = open("elisa_trial_2.tsv")
dst1 = open("elisa_trial_2_1.tsv", "w")
dst2 = open("elisa_trial_2_2.tsv", "w")
title = src.readline()
dst1.write(title)
dst2.write(title)
x = []
for l in src.readlines():
    content = l.split("\t")
    j = (content[0], content[1])
    if j in x:
        dst2.write(l)
    else:
        dst1.write(l)
        x.append(j)
src.close()
dst1.close()
dst2.close()
