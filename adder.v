module half_adder(sum, carry_out, input1, input2);
input input1, input2;
output sum, carry_out;

xor sum_of_digits(sum, input1, input2);
and carry_of_sum(carry_out, input1, input2);

endmodule

module full_adder(sum, carry_out, input1, input2, carry_in);
input input1, input2, carry_in;
output sum, carry_out;
wire temp_sum, first_carry_out, second_carry_out;

half_adder first_sum(temp_sum, first_carry_out, input1, input2);
half_adder second_sum(sum, second_carry_out, temp_sum, carry_in);

or final_carry_out(carry_out, second_carry_out, first_carry_out);

endmodule

module adder_2bit (out,carry_out,input1,input2,carry_in);
input [1:0] input1, input2;
input carry_in;
output carry_out;
output [1:0] out;
wire intermediate_carry;

full_adder f(out[0], intermediate_carry, input1[0], input2[0], carry_in),
           s(out[1], carry_out, input1[1], input2[1], intermediate_carry);
endmodule


module adder_4bit (out,carry_out,input1,input2,carry_in);
input [3:0] input1, input2;
input carry_in;
output carry_out;
output [3:0] out;
wire intermediate_carry;

adder_2bit f(out[1:0], intermediate_carry, input1[1:0], input2[1:0], carry_in),
           s(out[3:2], carry_out, input1[3:2], input2[3:2], intermediate_carry);
endmodule

module adder_8bit (out,carry_out,input1,input2,carry_in);
input [7:0] input1, input2;
input carry_in;
output carry_out;
output [7:0] out;
wire intermediate_carry;

adder_4bit f(out[3:0], intermediate_carry, input1[3:0], input2[3:0], carry_in),
            s(out[7:4], carry_out, input1[7:4], input2[7:4], intermediate_carry);
endmodule

module adder_16bit (out,carry_out,input1,input2,carry_in);
input [15:0] input1, input2;
input carry_in;
output carry_out;
output [15:0] out;
wire intermediate_carry;

adder_8bit f(out[7:0], intermediate_carry, input1[7:0], input2[7:0], carry_in),
            s(out[15:8], carry_out, input1[15:8], input2[15:8], intermediate_carry);
endmodule

module adder_32bit_i (out,carry_out,input1,input2,carry_in);
input [31:0] input1, input2;
input carry_in;
output carry_out;
output [31:0] out;
wire intermediate_carry;

adder_16bit f(out[15:0], intermediate_carry, input1[15:0], input2[15:0], carry_in),
            s(out[31:16], carry_out, input1[31:16], input2[31:16], intermediate_carry);
endmodule


module adder_32bit (out,input1,input2);
input [31:0] input1, input2;
wire carry_out;
output [31:0] out;
wire intermediate_carry;

adder_16bit f(out[15:0], intermediate_carry, input1[15:0], input2[15:0], 1'b0),
            s(out[31:16], carry_out, input1[31:16], input2[31:16], intermediate_carry);
endmodule
