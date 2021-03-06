`timescale 1ns/1ns
module Memory (input clk, rst, MemRead, MemWrite, input[31:0] Address, WriteData, output logic[31:0] ReadData);
  logic[31:0] Data[0:2100];
  initial
  begin
    $readmemb("Data.txt", Data);
  end
  always @(Address, MemRead) begin
    ReadData = 32'b0;
    if (MemRead)
      ReadData = Data[Address];
  end
  always @(posedge clk) begin
    if (MemWrite)
      Data[Address] = WriteData;
  end
endmodule