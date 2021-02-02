module control_unit(regDst, aluSrc, memToReg, regWrite, regWrite2, memRead, 
                    memWrite, branch, branchNotE, lui, jump, jal, aluop, opcode);	  
input [5:0] opcode;
output [1:0] aluop;
output regDst, aluSrc, memToReg, regWrite, regWrite2, memRead, memWrite, branch, branchNotE, lui, jump, jal;

wire rType, lw, sw, beq, bne, ori, j, jal_i, lui_i;
wire [5:0] opcode_not;

not_4_bit negateLeast4(opcode_not[3:0], opcode[3:0]);
not_2_bit negateMost2(opcode_not[5:4], opcode[5:4]);

and a1(rType, opcode_not[5], opcode_not[4], opcode_not[3], opcode_not[2], opcode_not[1], opcode_not[0]);
and a2(lw, opcode[5], opcode_not[4], opcode_not[3], opcode_not[2], opcode[1], opcode[0]);
and a3(sw, opcode[5], opcode_not[4], opcode[3], opcode_not[2], opcode[1], opcode[0]);
and a4(beq, opcode_not[5], opcode_not[4], opcode_not[3], opcode[2], opcode_not[1], opcode_not[0]);
and a5(bne, opcode_not[5], opcode_not[4], opcode_not[3], opcode[2], opcode_not[1], opcode[0]);
and a6(ori, opcode_not[5], opcode_not[4], opcode[3], opcode[2], opcode_not[1], opcode[0]);
and a7(j, opcode_not[5], opcode_not[4], opcode_not[3], opcode_not[2], opcode[1], opcode_not[0]);
and a8(jal_i, opcode_not[5], opcode_not[4], opcode_not[3], opcode_not[2], opcode[1], opcode[0]);
and a9(lui_i, opcode_not[5], opcode_not[4], opcode[3], opcode[2], opcode[1], opcode[0]);

buf b1(regDst, rType);
or o1(aluSrc, lw, sw, ori);
buf b2(memToReg, lw);
or o2(regWrite, rType, lw, ori, jal_i, lui);
buf b3(regWrite2, rType);
buf b4(memRead, lw);
buf b5(memWrite, sw);
buf b6(branch, beq);
buf b7(branchNotE, bne);
buf b8(jump, j);
buf b9(jal, jal_i);
buf b10(lui, lui_i);
or o3(aluop[1], rType, ori);
or o4(aluop[0], beq, bne, ori);

endmodule