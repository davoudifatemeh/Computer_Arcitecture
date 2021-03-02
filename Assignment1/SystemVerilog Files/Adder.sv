`timescale 1ns/1ns
module Adder(input [5:0] AOut, Q, output [5:0] A);
  assign A = AOut + Q;
endmodule
