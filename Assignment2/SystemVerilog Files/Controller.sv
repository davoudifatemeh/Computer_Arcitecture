`timescale 1ns/1ns
module Controller(input[31:0] Inst, input zero, output logic RegDst, RegWriteEN, ALUSrc, MemRead,
                  MemWrite, MemToReg, PCSrc, Jump, JR, Jal, sel31, slt, output logic[1:0] ALUControl);
  logic Branch;
  always @(Inst,zero)begin
    {RegDst, RegWriteEN, ALUSrc, MemRead, MemWrite, MemToReg, Branch, PCSrc, Jump, JR, Jal, sel31, slt} = 13'b0;
    ALUControl = 2'b0;
    case(Inst[31:26])
      6'b000010: Jump = 1'b1; //Jump
      6'b000011: begin Jump=1'b1; Jal=1'b1; sel31=1'b1; end //Jal
      6'b000001: JR=1'b1; //JR
      6'b000100: begin //beq
        Branch=1'b1; ALUControl=2'b01;
        PCSrc=zero&Branch;
      end
      6'b000101: begin ALUControl=2'b01; PCSrc = zero?0:1; end //bne
      6'b100011: begin 
      RegWriteEN=1'b1; ALUSrc=1'b1; MemRead=1'b1; 
      MemToReg=1'b1; 
      ALUControl=2'b00;end //Lw
      6'b101011: begin ALUSrc=1'b1; MemWrite=1'b1; ALUControl=2'b00;end //Sw
      6'b001000: begin ALUControl=2'b00; RegWriteEN=1'b1; ALUSrc=1'b1;end //addi
      6'b001100: begin ALUControl=2'b10; RegWriteEN=1'b1; ALUSrc=1'b1; end //andi
      6'b000000: begin //RT
        RegDst=1'b1; RegWriteEN=1'b1; MemToReg=1'b1;
        case(Inst[5:0])
          6'b100000: ALUControl=2'b00; //Add
          6'b100010: ALUControl=2'b01; //Sub
          6'b100100: ALUControl=2'b10; //And
          6'b100101: ALUControl=2'b11; //Or
          6'b101010: slt=1'b1; //slt
        endcase
      end
    endcase
  end       
endmodule