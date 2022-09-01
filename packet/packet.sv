class packet;
  rand bit[2:0]addr;
  constraintaddr_range{addr>5;}
endclass

module constr_blocks;
  initial begin
    packet pkt;
    pkt=new();
    repeat(10)begin
      pkt.randomize();
      $display("\taddr=%0d",pkt.addr);
    end
  end
endmodule
