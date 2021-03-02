`timescale 1ns/1ns
module PC(input clk, rst, input[31:0] pcIn, output logic[31:0] pcOut);
  always@(posedge clk, posedge rst) begin
    if (rst)
      pcOut <= 32'b0;
    else
      pcOut <= pcIn;
  end
endmodule
