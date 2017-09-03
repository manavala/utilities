//qverilog wait_order1.sv

module events_ex;
  event ev_1; //declaring event ev_1
  event ev_2; //declaring event ev_2
  event ev_3; //declaring event ev_3
  
  initial begin
    fork
      //process-1, triggers the event ev_1
      begin
        #6;
        $display($time,"\tTriggering The Event ev_1");
        ->ev_1;
      end
      //process-2, triggers the event ev_2
      begin
        #2;
        $display($time,"\tTriggering The Event ev_2");
        ->ev_2;
      end
      //process-3, triggers the event ev_3
      begin
        #8;
        $display($time,"\tTriggering The Event ev_3");
        ->ev_3;
      end
      //process-4, wait for the events to trigger in order of ev_2,ev_1 and ev_3
      begin
        $display($time,"\tWaiting for the Event's to trigger");
        wait_order(ev_2,ev_1,ev_3)
          $display($time,"\tEvent's triggered Inorder");
        else
          $display($time,"\tEvent's triggered Out-Of-Order");
      end
    join
  end
endmodule
