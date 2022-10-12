// Code your testbench here
// or browse Examples
`include "interface.sv"
`include "test.sv"

module tbench_top;
  
  //clock and reset signal declaration
  bit clk;
  bit reset;
  
  //clock generation
  always #5 clk = ~clk;
  
  //rest generation
  initial begin
    reset = 1;
    #5 reset = 0;
  end
  
  
  
  INTERFACE
  //Combines all signals
interface intf(input logic clk,reset);
  logic rstn;
  logic vld;
  logic [7:0] addr;
  logic [15:0]data;
   logic [7:0] addr_a;
  logic [15:0]data_a;
   logic [7:0] addr_b;
  logic [15:0]data_b;
endinterface
  
  class switch_item;
 //declaring transaction items
  rand bit [7:0]  addr;
  rand bit [15:0] 	data;
  bit [7:0] addr_a;//output can’t be randomized
  bit [15:0] data_a;
  bit [7:0] addr_b;
  bit [15:0] data_b;
function void print ()
    $display(“------------------------------------”);
$display(“-addr=%0s”, a);
$display(“-addr=%0s, b);
$display(“-data =%0s,a);
$display(“-data=%0s”,b);
  endfunction
endclass

  
  class generator;
//task main is declared in generator class
//Declaring transaction class
rand transaction trans;
//declaring the mailbox
  Mailbox  gen2driv; 
//constructor
  function new(mailbox gen2driv);
//event,to indicate the event ended
  event ended;
//repeat count,to count the number of values
  int repeat_count;
int count=10;
//getting the mailbox handle from env
  this.gen2driv = gen2driv;
  endfunction
  
  //main task, generates the repeat_count number of transaction //packets into mailbox
    task main();    
repeat(repeat_count) begin
        trans = new();
        if(!trans.randomize())$fatal("Gen::trans randomization failed");
        gen2driv.put(trans);
      end
      ->ended;//triggering indicates the end of generation
    endtask
 endclass
endclass





  class monitor
virtual intf vif;
//declaration of mailbox
mailbox mon2scb;
function void intf(vif.addr , vif.data)
task main()
this.vif=vif();
for(i=0;i<10;i++)begin 
mailbox get(trans,mon2scb);
end 
endclass
endfunction

  
  
  //task main is declared in driver
//reset is declared in driver block
//counting the number of transactions 
class driver 
driver (input clk,input rstn)
repeat_count  notransactions;
task main();
begin
@(posedge vif)
this.vif=vif;
@(posedge vif)
trans.addr=a;
trans.addr=b;
@(posedge vif)
trans.data=a;
trans.data=b;
monitor put(mon2scb ,trans)
end
endfunction
endclass




  
  //checks packets address
//declaring the scoreboard
class scoreboard
generator gen;
driver driv;
transaction trans;
monitor mon;
//compare output values
task main();
begin
If(trans.addr==a,trans.addr==b,trans.data==a,trans.data==b)
$display(“--------------------------------------“);
$display(“---the output values are---“);
else
$display(“error”);
end
endtask

  
  
  //includes all the blocks
//hold the values from scoreboard
`include generator ;
`include driver;
`include scoreboard;
`include transaction;
`include monitor;
class environment;
   
  //generator and driver instance
  generator gen;
  driver driv;
  monitor mon;
  scoreboard scb;
   
  //mailbox handle's
  mailbox gen2driv;
  mailbox mon2scb;
   
  //virtual interface
  virtual intf vif;
  
   //virtual interface
  virtual intf vif;
   
  //constructor
  function new(virtual intf vif);
    //get the interface from test
    this.vif = vif;
     
    //creating the mailbox (Same handle will be shared across generator and driver)
    gen2driv = new();
    mon2scb  = new();
     
    //creating generator and driver
    gen  = new(gen2driv);
    driv = new(vif,gen2driv);
    mon  = new(vif,mon2scb);
    scb  = new(mon2scb);
  endfunction
   
  task pre_test();
    driv.reset();
  endtask
   
  task test();
    fork
      gen.main();
      driv.main();
      mon.main();
      scb.main();
    join_any
  endtask
   
  task post_test();
    wait(gen.ended.triggered);
    wait(gen.repeat_count == driv.no_transactions); 
    wait(gen.repeat_count == scb.no_transactions);
  endtask 
  
  //run task
  task run;
    pre_test();
    test();
    post_test();
    $finish;
  endtask

endclass
  
  class test;
  environment env;
  function new();
    env=new;
  endfunction
  task run();
    env.run();
  endtask
  end class
