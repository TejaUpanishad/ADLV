module queues_arraydelete;
  //array declaration
  bit [31:0]queue_1[$];//unbounded queue
  string queue_2[$];
  initial begin
    //queue initialization:
    queue_1={0,1,2,3};
    queue_2={"Red","Blue","Green"};
    //size-method
    $display("---Queue_1 size is %0d---",queue_1.size());
    foreach(queue_1[i]) $display("\tqueue_1[%0d]=%0d",i,queue_1[i]);
    $display("---Queue_2 size is %0d---",queue_1.size());
    foreach(queue_2[i]) $display("\tqueue_2[%0d]=%0s",i,queue_2[i]);
    //Insert-method
    queue_2.insert(1,"Green");
    $display("---Queue_2 size after inserting Green is %0d---",queue_2.size());
    foreach(queue_2[i]) $display("\tqueue_2[%0d]=%0s",i,queue_2[i]);
    //delete -method
    queue_2.delete(3);
    $display("---Queue_2 size after delete is %0d---",queue_2.size());
    foreach(queue_2[i]) $display("\tqueue_2[%0d]=%0s",i,queue_2[i]);
  end
endmodule
