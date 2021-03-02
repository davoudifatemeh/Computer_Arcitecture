`timescale 1ns/1ns
module ALU(input[31:0] A, B, input[1:0] ALUControl,output logic [31:0] result, output zero);
  always @(A, B, ALUControl) begin
    result = 32'b0;
    case(ALUControl)
      2'b00: result = A + B;
      2'b01: result = A - B;
      2'b10: result = A & B;
      2'b11: result = A | B; 
      default:result = A + B;
    endcase
  end
  assign zero = (A == B) ? 1'b1 : 1'b0;
endmodule