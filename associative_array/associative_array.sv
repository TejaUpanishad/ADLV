module associative_array
  //array declaration
  int a_array[*];
  int index;
 initial begin
   //allocating array and assigning value to it
   repeat(3) begin
     a_array[index]=index*2;
     index=index+4;
   end
   //num()-Associative array method
   $display("\t Number of entries in a_array is %0d",a_array.num());
   $display("---Associative array a_array entries and Values are---");
   foreach(a_array[i]) $display("\ta_array is %0d",a_array.num());
   $display("--------------------------------");
   //first()-Associative array method
   a_array.first(index);
   $display("\first entry is \ta_array[%0d]=%0d",index,a_array[index]);
    //last()-Associative array method
   a_array.last(index);
   $display("\last entry is \ta_array[%0d]=%0d",index,a_array[index]);
 end
endmodule
   
