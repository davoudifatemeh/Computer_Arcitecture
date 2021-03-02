`timescale 1ns/1ns
module BoothMULT (input clk, rst, start, input [5:0] iBus, output [11:0] oBus);
  wire [5:0] A, X, Y, Ybar, AOut, xOut, Q;
  wire ldA, shA, clrA, ldX, shX, ldY, ldYbar, ldx, clrx, selY, selYbar, sel0, co;
  Controller CTRL(clk, rst, X[0], xOut, start, shA, clrA, ldA, shX, ldX, clrx,
                  ldx, ldY, ldYbar, selY, selYbar, sel0, co);
  ShReg6A AReg(clk, rst, ldA, shA, clrA, A, AOut);
  ShReg6X XReg(clk, rst, ldX, shX, A[0], iBus, X);
  ShReg1X xReg(clk, rst, ldx, clrx, X[0], xOut);
  Reg6Y YReg(clk, rst, ldY, iBus, Y);
  Reg6YBar YbarReg(clk, rst, ldYbar, Y, Ybar);
  MUX3 MUX(selY, selYbar, sel0, Y, Ybar, Q);
  Adder add(AOut, Q, A);
  assign oBus = {A,X};
endmodule
