module enum_datatype;
  //declaration
  enum{red,green,blue,yellow,white,black} Colors;
  //display members of Colors
  initial begin
    Colors =Colors.first;
    for(i=0;i<6;i++)begin
      $display("Colors :: Value of %0s\t is =%0d",Colors.name,Colors)
      Colors = Colors.next;
    end
  end
endmodule
