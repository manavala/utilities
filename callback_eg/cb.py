## callback
## pass the "function" as the argument to other function
#copied from youtube

#!/usr/bin/env python

def my_square(val):
  return val ** 2;

def caller(val,func):
  return func(val)

for i in range(5):
  j=caller(i,my_square)
  print "# %s %s" % (i, j)

#output
#0 0
#1 1
#2 4
#3 9
#4 16
