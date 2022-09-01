module foreach_loop_break;
  int a[4];
     initial begin
    $display("-----------------------------------------------------------------");
      foreach(a[i]) a[i] = i;
    foreach(a[i]) begin
      $display("\tValue of a[%0d]=%0d",i,a[i]);
      if(i == 2) begin
        $display("\tCalling break,");
        break;
      end 
    end     
         $display("-----------------------------------------------------------------");
  end    
endmodule
