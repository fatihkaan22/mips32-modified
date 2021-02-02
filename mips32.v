module mips32(clock);
wire [31:0] instruction;
wire [31:0] rs_rt_res;

input clock;

// control unit outputs
wire regDst, aluSrc, memToReg, regWrite, regWrite2, memRead, memWrite, branch, branchNotE, lui, jump, jal;
wire [1:0] aluop;

// alu outputs
wire alu_zero_out, alu_zero_out_not;
wire [31:0] alu_result;
wire [2:0] alu_control_out;

// mux outputs
wire [4:0] mux_rt_rs_out;
wire [31:0] mux_jal_pc_out, mux_lui_out, load_up_16_out, mux_branch_out, mux_aluSrc_out, adder_branch_out, mux_j_out, mux_jr_out;
wire [4:0] mux_jal_ra_out;

// register
wire[31:0] read_data_1, read_data_2;

// data memory
wire[31:0] memory_read_data_out;

wire [31:0] new_out, pc_plus_1, sign_extend_out, shift_left_2_out;
wire or_j_out, and_branch_out, and_branchNot_out;

wire jr;

wire [31:0] pc_reg_out;

wire [31:0] jump_address = {pc_reg_out[31:26], instruction[25:0]};

reg rst;
register_32 pc_reg(mux_j_out, rst, pc_reg_out, clock);

mux_2_to_1_32bit mux_jr(jump_address, read_data_1, jr, mux_jr_out);
or j_jr_jal_select(or_j_out, jump, jal, jr);
mux_2_to_1_32bit mux_j(mux_branch_out, mux_jr_out, or_j_out, mux_j_out);

wire [31:0] constant1 = 32'd1;
adder_32bit adder_pc_plus_1(pc_plus_1, pc_reg_out, constant1);

instruction_memory instruction_memory1(instruction, pc_reg_out[11:0]); // 12 bit address is enough to represent 16KB instruction memory

control_unit control_unit1(regDst, aluSrc, memToReg, regWrite, regWrite2, memRead, memWrite, branch, branchNotE, lui, jump, jal, aluop, instruction[31:26]); // opcode

load_upper_16 loadU16(load_up_16_out, instruction[15:0]);

// muxes in front of write register
mux_2_to_1_5bit mux_rt_rs(instruction[20:16], instruction[25:21], regDst, mux_rt_rs_out);					  
mux_2_to_1_5bit mux_jal_ra(mux_rt_rs_out, 5'b11111, jal, mux_jal_ra_out);
// muxes in front of write data
mux_2_to_1_32bit mux_jal_pc(rs_rt_res, pc_plus_1, jal, mux_jal_pc_out);
mux_2_to_1_32bit mux_lui(mux_jal_pc_out, load_up_16_out, lui, mux_lui_out);

mips_registers register_block(read_data_1, read_data_2, mux_lui_out, new_out, instruction[25:21], instruction[20:16], mux_jal_ra_out, instruction[15:11], regWrite, regWrite2, clock );

sign_extend_16_32 sign_extend(instruction[15:0], sign_extend_out); // immediate

// shift_left_2 shift_left(sign_extend_out, shift_left_2_out);

adder_32bit adder_branch(adder_branch_out, sign_extend_out, pc_plus_1);

mux_2_to_1_32bit mux_aluSrc(read_data_2, sign_extend_out, aluSrc, mux_aluSrc_out);

alu_control alu_control_1(alu_control_out, jr, instruction[5:0], aluop);

alu_32bit alu(read_data_1, mux_aluSrc_out, alu_control_out, alu_result, alu_zero_out);

and isBranchZero(and_branch_out, branch, alu_zero_out);
not negateZero(alu_zero_out_not, alu_zero_out);
and isBranchNotZero(and_branchNot_out, branchNotE, alu_zero_out_not);
wire orBranch_out;
or orBranch(orBranch_out, and_branchNot_out, and_branch_out);

mux_2_to_1_32bit mux_branch(pc_plus_1, adder_branch_out, orBranch_out, mux_branch_out);

mips_data_memory data_mem(memory_read_data_out, alu_result[15:0], read_data_2, memWrite, memRead, clock); // 16 bit address is enough to represent 256KB data memory

mux_2_to_1_32bit mux_memToReg(alu_result, memory_read_data_out, memToReg, rs_rt_res);

new_get_rd new_block(rs_rt_res, new_out);

endmodule
