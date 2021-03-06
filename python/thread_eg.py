from threading import Thread 
import time 
import sys 
 
def func1(a,b): 
  print 'func1: starting 1 sec' 
  delay = a*b 
  time.sleep(delay) 
  print ('func1: finishing',delay) 
 
def func2(a,b): 
  print 'func2: starting 2 sec' 
  delay = a*b*2 
  time.sleep(delay) 
  print ( 'func2: finishing', delay) 
 
def run(run_list): 
  threads = [] 
  for ii in run_list: 
      # We start one thread per url present. 
      print ii["func"], ii["arg1"], ii["arg2"] 
      process = Thread(target=ii["func"], args=[ii["arg1"], ii["arg2"]]) 
      process.start() 
      threads.append(process) 
  # We now pause execution on the main thread by 'joining' all of our started threads. 
  # This ensures that each has finished processing the urls. 
  for process in threads: 
      process.join() 
   
if __name__ == '__main__': 
  run_list = [ { "func" : func1, "arg1": 1, "arg2" : 2}, 
               { "func" : func2, "arg1": 1, "arg2" : 2}, 
               ] 
  run(run_list) 
  sys.exit() 
