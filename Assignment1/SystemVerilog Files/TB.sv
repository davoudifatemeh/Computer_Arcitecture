`timescale 1ns/1ns
module TB();
  logic [5:0] in;
  logic clk, rst, start;
  logic [11:0]out;
  BoothMULT MULT(clk, rst, start, in, out);
  initial begin
    in = 6'b0; rst = 1; start = 1'b1;
    #200 rst = 0;
    #300 clk = 0; 
    #200 in = 6'b001011;
    #300 clk = 1;
    #300 clk = 0;
    #200 in = 6'b110011;
    #300 clk = 1;
    repeat (100) #400 clk = ~clk;
    #200 $stop;
  end
endmodule
