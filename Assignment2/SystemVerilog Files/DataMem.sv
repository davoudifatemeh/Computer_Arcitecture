`timescale 1ns/1ns
module DataMem(input clk, rst, MemWriteEN, MemReadEN, input[31:0] addr, WriteData,
               output logic[31:0] ReadData);    
  logic [31:0] memory [0:32767];  
  integer i;  
  initial begin
    $readmemb("memdata.txt", memory); 
  end 
  always @(addr, MemReadEN) begin
    ReadData = 32'b0;
    if(MemReadEN)
      ReadData = memory[addr];
  end 
  always @(posedge clk) begin    
    if (MemWriteEN)
        memory[addr] <= WriteData;
  end
endmodule