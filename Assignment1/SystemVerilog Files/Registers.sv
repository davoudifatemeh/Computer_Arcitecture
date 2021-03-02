
`timescale 1ns/1ns
module ShReg6X(input clk, rst, ld, shEn, A0, input[5:0] XIn, output logic[5:0] XOut);
  always @(posedge clk, posedge rst) begin
    if (rst)
      XOut <= 6'b000000;
    else begin
      if (ld)
        XOut <= XIn;
      else if (shEn)
        XOut <= {A0, XOut[5:1]};
    end
  end
endmodule

module ShReg6A(input clk, rst, ld, shEn, clrA, input[5:0] AIn, output logic[5:0] AOut);
  always @(posedge clk, posedge rst) begin
    if (rst)
      AOut <= 6'b000000;
    else begin
      if (ld)
        AOut <= AIn;
      else if (shEn)
        AOut <= {AOut[5], AOut[5:1]};
      else  if (clrA)
        AOut <= 6'b000000;
    end
  end
endmodule

module Reg6Y(input clk, rst, ld, input[5:0] YIn, output logic[5:0] YOut);
  always @(posedge clk, posedge rst) begin
    if (rst)
      YOut <= 6'b000000;
    else
      if (ld)
        YOut <= YIn;
  end
endmodule

module Reg6YBar(input clk, rst, ld, input[5:0] Y, output logic[5:0] YBar);
  always @(posedge clk, posedge rst) begin
    if (rst)
      YBar <= 6'b000000;
    else
      if (ld)
        YBar <= ~Y + 1;
  end
endmodule

module ShReg1X(input clk, rst, ld, clrx, xIn, output logic xOut);
  always @(posedge clk, posedge rst) begin
    if (rst)
      xOut <= 1'b0;
    else
      if (clrx)
        xOut <= 1'b0;
      else if (ld)
        xOut <= xIn;
  end
endmodule


