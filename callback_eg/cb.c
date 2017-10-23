//copied from wikipedia
//callback pass function name as argument to other function

#include "stdio.h"
#include "stdlib.h"

void PrintTwoNumbers(int (*numbersource)(void)) {
  int val1=numbersource();
  int val2=numbersource();
  printf("val1 %0d val2 %0d\n", val1,val2);
}


int OverNineThousand(void) {
  return (rand()%1000 + 9001);
}

int just42(void) {
  return 42;
}

int main(void) {
  
  PrintTwoNumbers(&rand);
  PrintTwoNumbers(&OverNineThousand);
  PrintTwoNumbers(&just42);

} 


// output
// val1 1804289383 val2 846930886
// val1 9778 val2 9916
// val1 42 val2 42
