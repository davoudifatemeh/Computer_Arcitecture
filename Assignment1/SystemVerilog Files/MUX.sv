`timescale 1ns/1ns
module MUX3(input selY, selYbar, sel0,input [5:0]y, ybar, output [5:0]Q);
   assign Q = selY ? y : ( selYbar ? ybar : ( sel0 ? 6'b0 : 6'b0) ) ;
endmodule

