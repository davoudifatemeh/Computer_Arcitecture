`timescale 1ns/1ns
module SignExtend(input[15:0]A, output logic[31:0]W);
  always @(A)begin
    W = {{16{A[15]}}, A};
  end
endmodule 
