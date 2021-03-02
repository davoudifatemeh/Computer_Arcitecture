`timescale 1ns/1ns
module DataPath(input clk, rst, RegDst, RegWriteEN, ALUSrc, MemRead, MemWrite, MemToReg, PCSrc, Jump, JR, Jal,
                sel31, slt, input[1:0] ALUControl, output[31:0] Inst, output zero);
  logic[31:0] pcOut, inst, WriteDataFirst, WriteData, ReadData1, ReadData2, AddrResult, oprand1, ReadData, memData, mux6Out,
              mux7Out;
  wire[31:0] pcIn;
  wire [4:0] WriteReg1, WriteReg2;
  wire [4:0] r31;
  assign r31 = 5'b11111;
  wire [31:0] signex, pcNext1, pcNext2;
  wire [31:0] JumpAddr;
  assign JumpAddr = {pcOut[31:28], inst[25:0], 2'b0};
  wire [31:0] shlSignex;
  assign shlSignex = {signex[29:0], 2'b0};
  assign pcNext1 = pcOut + 4;
  assign pcNext2 = pcNext1 + shlSignex;
  PC pc(clk, rst, pcIn, pcOut);
  MUX2_32 mux6(PCSrc, pcNext2, pcNext1, mux6Out);
  MUX2_32 mux7(Jump, JumpAddr, mux6Out, mux7Out);
  MUX2_32 mux8(JR, ReadData1, mux7Out, pcIn); 
  InstMem instmem(pcOut, inst);
  MUX2_5 mux1(RegDst, inst[15:11], inst[20:16], WriteReg1);
  MUX2_5 mux2(sel31, r31, WriteReg1, WriteReg2);
  SignExtend SignEx(inst[15:0], signex);
  MUX2_32 mux3(ALUSrc, signex, ReadData2, oprand1);
  ALU alu(ReadData1, oprand1, ALUControl, AddrResult, zero);
  DataMem datamem(clk, rst, MemWrite, MemRead, AddrResult, ReadData2, ReadData);
  MUX2_32 mux4(MemToReg, ReadData, AddrResult, memData);
  MUX2_32 mux5(Jal, pcNext1, memData, WriteDataFirst);
  RegFile regfile(clk, rst, RegWriteEN, WriteReg2, inst[25:21], inst[20:16], WriteData, ReadData1, ReadData2);
  assign WriteData = slt ? ((ReadData1 < ReadData2) ? 1 : 0): WriteDataFirst;
  assign Inst = inst;
endmodule