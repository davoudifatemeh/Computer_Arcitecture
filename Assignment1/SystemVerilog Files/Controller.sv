`timescale 1ns/1ns
module Controller(input clk, rst, X0, x, start, output logic shA, clrA, ldA, shX, ldX, clrx,
                  ldx, ldY, ldYbar, selY, selYbar, sel0, output co);
  logic ldc, cEn;
  logic [2:0] cIn, cOut;
  parameter [3:0] A=4'b0000, B=4'b0001, C=4'b0010, D=4'b0011, E=4'b0100,
                  F=4'b0101, G=4'b0110, H=4'b0111, I=4'b1000, J=4'b1001;
  logic [3:0] ns, ps;
  
  always @(posedge clk, posedge rst) begin  //count to six
    if(rst) cOut <= 3'b0;
    else if(ldc) cOut <= cIn;
    else if(cEn) cOut <= cOut + 1;
    cIn <= 3'b001;
  end 
  assign co = &{cOut};
  
  always @(X0, x, ps) begin  //combinational part
    {shA, clrA, ldA, shX, ldX, clrx, ldx, ldY, ldYbar, selY, selYbar, sel0, ldc, cEn} = 14'b0;
    ns = A;
    case(ps)
      A: begin ldY = 1'b1; clrx = 1'b1; clrA = 1'b1; ldc = 1'b1; ns = start ? B : A; end
      B: begin
           ldY = 1'b0; clrx = 1'b0; clrA = 1'b0; ldc = 1'b0;
           ldX = 1'b1; ldYbar = 1'b1; ns = C;
         end
      C: begin ldX = 1'b0; ldYbar = 1'b0; ns = D; end

      D: begin 
            case({X0,x})
              2'b0: ns = E;
              2'b11: ns = E;
              2'b01: ns = F;
              2'b10: ns = G;
            endcase
          end
      E: begin ldx = 1'b1; sel0 = 1'b1; cEn = 1'b1; ns = H; ldA = 1'b1; end
      F: begin ldx = 1'b1; selY = 1'b1; cEn = 1'b1; ns = H; ldA = 1'b1; end
      G: begin ldx = 1'b1; selYbar = 1'b1; cEn = 1'b1; ns = H; ldA = 1'b1; end
      H: begin 
            ldx = 1'b0; selYbar = 1'b0; selY = 1'b0; sel0 = 1'b0; cEn = 1'b0; ns = I;
         end
      I: begin shA = 1'b1; shX = 1'b1; ldA = 1'b0; ns = J; end   
      J: begin shA = 1'b0; shX = 1'b0; ns = co ? A : D; end
      default
      ns = A;
    endcase
  end
    always @(posedge clk, posedge rst) begin  //sequential part
      if(rst) ps <= A;
      else ps <= ns;
    end
  assign P = ps;
endmodule


