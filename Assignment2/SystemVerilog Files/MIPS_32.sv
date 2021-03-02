`timescale 1ns/1ns
module MIPS_32(input clk, rst);
  wire RegDst, RegWriteEN, ALUSrc, MemRead, MemWrite, MemToReg, PCSrc, Jump, JR, Jal, sel31, slt, zero;
  wire[1:0] ALUControl;
  wire[31:0] Inst;
  DataPath dp(clk, rst, RegDst, RegWriteEN, ALUSrc, MemRead, MemWrite, MemToReg, PCSrc, Jump, JR, Jal,
              sel31, slt, ALUControl, Inst, zero);
  Controller ctrl(Inst, zero, RegDst, RegWriteEN, ALUSrc, MemRead,MemWrite, MemToReg, PCSrc, Jump, JR,
                  Jal, sel31, slt, ALUControl);
endmodule