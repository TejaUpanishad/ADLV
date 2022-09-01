module repeat_loop_break;
  int i;
     initial begin
    $display("-----------------------------------------------------------------");
repeat(5) begin
  $display("\tValue of i=%0d",i);
  if(i == 2) begin
    $display("\tCalling break,");
    break;
  end
      i++;
    end     
         $display("-----------------------------------------------------------------");
  end    
endmodule
