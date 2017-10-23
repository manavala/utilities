//Call back function c code copied from wikipedia

#include "stdio.h"
#include "stdlib.h"
#include "string.h"

typedef struct MyMsg_ {
  int appId;
  char msgBody [32];
} MyMsg;

void myfunc(MyMsg *mymsg) {
  if(strlen(mymsg->msgBody)>0) {
    printf("//id %0d msg %0s\n",mymsg->appId,mymsg->msgBody);
  }
  else {
    printf ("//id %0d no msg\n",mymsg->appId);
  }
}

void (*callback)(MyMsg *);

int main(void) {

  MyMsg m1,m2;
  m1.appId = 25;
  strcpy(m1.msgBody,"testing");
  callback = myfunc;
  callback(&m1);
  m2=m1;
  strcpy(m2.msgBody,"");
  callback(&m2);

}


// output
//id 25 msg testing
//id 25 no msg
