`timescale 1ns/1ns
module InstMem(input [31:0]pc, output [31:0] instruction);    
  logic [31:0] instByte[0:32767];  
  initial begin
    $readmemb("meminst.txt", instByte); 
  end
  assign instruction = instByte[pc];  
endmodule
