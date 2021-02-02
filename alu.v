module alu_1bit(a, b, sel, out, overflow, carry_in, carry_out);

input a, b;
input [2:0] sel;
input carry_in;
output out;
output overflow, carry_out;

wire and_res, or_res, xor_res, add_res, b_adder_in, mux1_out, mux2_out;

// 1's complement to perform substraction if sub selected
and and_operation(and_res, a, b);
or or_operation(or_res, a, b);
xor xor_opeartion(xor_res, a, b);
xor _1s_complement(b_adder_in, b, sel[0]);
// b_adder_in: b if add, 1's complement of b if sub, carry_in: 1 if sub
full_adder adder(add_res, carry_out, a, b_adder_in, carry_in);
xor(overflow,carry_in, carry_out);

// and/or mux
mux_2_to_1 mux1(and_res, or_res, sel[0], mux1_out);
// adder/xor mux
mux_2_to_1 mux2(add_res, xor_res, sel[1], mux2_out);
// mux1/mux2 mux
mux_2_to_1 mux3(mux1_out, mux2_out, sel[2], out);
endmodule

module alu_2bit(a, b, sel, out, overflow, zero, carry_in, carry_out);

input [1:0] a, b;
input [2:0] sel;
input carry_in;
output [1:0] out;
output overflow, zero, carry_out;

alu_1bit f(a[0], b[0], sel[2:0], out[0], _, carry_in, intermediate_carry),
         s(a[1], b[1], sel[2:0], out[1], overflow, intermediate_carry, carry_out);
			
or(zero, out[0], out[1]);

endmodule



module alu_4bit (a, b, sel, out, overflow, zero, carry_in, carry_out);
input [3:0] a, b;
input [2:0] sel;
input carry_in;
output [3:0] out;
output overflow,zero, carry_out;
wire zero1, zero2;

alu_2bit f(a[1:0], b[1:0], sel[2:0], out[1:0], _, zero1, carry_in, intermediate_carry),
          s(a[3:2], b[3:2], sel[2:0], out[3:2], overflow, zero2, intermediate_carry, carry_out);

or(zero, zero1, zero2);

endmodule

module alu_8bit (a, b, sel, out, overflow, zero, carry_in, carry_out);
input [7:0] a, b;
input [2:0] sel;
input carry_in;
output [7:0] out;
output overflow, zero, carry_out;
wire zero1, zero2;

alu_4bit f(a[3:0], b[3:0], sel[2:0], out[3:0], _, zero1, carry_in, intermediate_carry),
          s(a[7:4], b[7:4], sel[2:0], out[7:4], overflow, zero2, intermediate_carry, carry_out);
or(zero, zero1, zero2);
endmodule

module alu_16bit (a, b, sel, out, overflow, zero, carry_in, carry_out);
input [15:0] a, b;
input [2:0] sel;
input carry_in;
output [15:0] out;
output overflow, zero, carry_out;
wire zero1, zero2;

alu_8bit f(a[7:0], b[7:0], sel[2:0], out[7:0], _, zero1, carry_in, intermediate_carry),
          s(a[15:8], b[15:8], sel[2:0], out[15:8], overflow, zero2, intermediate_carry, carry_out);
or(zero, zero1, zero2);

endmodule


// 32 bit ALU

//module alu_32bit (a, b, sel, out, overflow, zero, carry_in, carry_out);
//input [31:0] a, b;
//input [2:0] sel;
//input carry_in;
//output [31:0] out;
//output overflow, zero, carry_out;
//
//alu_16bit f(a[15:0], b[15:0], sel[2:0], out[15:0], _, zero1, carry_in, intermediate_carry),
//          s(a[31:16], b[31:16], sel[2:0], out[31:16], overflow, zero2, intermediate_carry, carry_out);
//or(zero, zero1, zero2);
//endmodule


// 32 bit ALU w/o carry_in, carry_out, overflow and w/zero out inversion
module alu_32bit (a, b, sel, out, zero);
input [31:0] a, b;
input [2:0] sel;
output [31:0] out;
output zero;
wire zero_not;

alu_16bit f(a[15:0], b[15:0], sel[2:0], out[15:0], _, zero1, sel[0], intermediate_carry),
          s(a[31:16], b[31:16], sel[2:0], out[31:16], overflow, zero2, intermediate_carry, carry_out);
or(zero_not, zero1, zero2);
not(zero, zero_not);

endmodule


