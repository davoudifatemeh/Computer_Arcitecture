`timescale 1ns/1ns
module RegFile(input clk, rst, RegWriteEN, input[4:0] WriteReg, ReadReg1, ReadReg2, 
               input[31:0] WriteData, output[31:0] ReadData1, ReadData2);
  logic[31:0] reg_array [0:31];
  integer i;
  initial begin
    reg_array[0] = 32'b0;
  end
  always@(posedge clk) begin 
    if(RegWriteEN) begin
      reg_array[WriteReg] <= WriteData;
    end
  end
  assign ReadData1 = ( ReadReg1 == 0)? 32'b0 : reg_array[ReadReg1];
  assign ReadData2 = ( ReadReg2 == 0)? 32'b0 : reg_array[ReadReg2];
endmodule 