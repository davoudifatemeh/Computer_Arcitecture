`timescale 1ns/1ns
module MUX2_5(input selector, input[4:0] A, B, output logic[4:0] out);
  always @(A, B, selector) begin
    out = 5'b0;
    case(selector)
      1'b0: out = B;
      1'b1: out = A;
    endcase
  end
endmodule

module MUX2_32(input selector, input[31:0] A, B, output logic[31:0] out);
  always @(A, B, selector) begin
    out = 32'b0;
    case(selector)
      1'b0: out = B;
      1'b1: out = A;
    endcase
  end
endmodule