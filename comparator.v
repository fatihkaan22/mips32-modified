// therer are greater than, less than and equal inputs; so that we can cascade 1 bit comparators to create a 32 bit comparator

module comparator_1bit(a, b, in_gt, in_lt, in_eq, out_gt, out_lt, out_eq);

input a, b;
input in_gt, in_lt, in_eq;
output out_gt, out_lt, out_eq;

wire a_not, b_not;

not n1(a_not, a);
not n2(b_not, b);

// out_gt = in_gt + (in_eq * a * b')
and a1(and1, a, b_not);
and a2(or1, and1, in_eq);
or o1(out_gt, or1, in_gt);

// out_lt = in_lt + (in_eq * a' * b)
and a3(and2, a_not, b);
and a4(or2, and2, in_eq);
or o2(out_lt, or2, in_lt);

// out_eq = in_eq + (a XNOR b)
xnor x1(and3,a,b);
and a5(out_eq, and3, in_eq);

endmodule

module comparator_2bit(a, b, in_gt, in_lt, in_eq, out_gt, out_lt, out_eq);
input [1:0] a, b;
input in_gt, in_lt, in_eq;
output out_gt, out_lt, out_eq;

comparator_1bit f(a[1], b[1], in_gt, in_lt, in_eq, pre_out_gt, pre_out_lt, pre_out_eq),
                 s(a[0], b[0], pre_out_gt, pre_out_lt, pre_out_eq, out_gt, out_lt, out_eq);
endmodule

module comparator_4bit (a, b, in_gt, in_lt, in_eq, out_gt, out_lt, out_eq);
input [3:0] a, b;
input in_gt, in_lt, in_eq;
output out_gt, out_lt, out_eq;

comparator_2bit f(a[1:0], b[1:0], in_gt, in_lt, in_eq, pre_out_gt, pre_out_lt, pre_out_eq),
                 s(a[3:2], b[3:2], pre_out_gt, pre_out_lt, pre_out_eq, out_gt, out_lt, out_eq);
endmodule

module comparator_8bit (a, b, in_gt, in_lt, in_eq, out_gt, out_lt, out_eq);
input [7:0] a, b;
input in_gt, in_lt, in_eq;
output out_gt, out_lt, out_eq;

comparator_4bit f(a[3:0], b[3:0], in_gt, in_lt, in_eq, pre_out_gt, pre_out_lt, pre_out_eq),
                 s(a[7:4], b[7:4], pre_out_gt, pre_out_lt, pre_out_eq, out_gt, out_lt, out_eq);
endmodule

module comparator_16bit (a, b, in_gt, in_lt, in_eq, out_gt, out_lt, out_eq);
input [15:0] a, b;
input in_gt, in_lt, in_eq;
output out_gt, out_lt, out_eq;

comparator_8bit f(a[7:0], b[7:0], in_gt, in_lt, in_eq, pre_out_gt, pre_out_lt, pre_out_eq),
                 s(a[15:8], b[15:8], pre_out_gt, pre_out_lt, pre_out_eq, out_gt, out_lt, out_eq);
endmodule

module comparator_32bit (a, b, in_gt, in_lt, in_eq, out_gt, out_lt, out_eq);
input [31:0] a, b;
input in_gt, in_lt, in_eq;
output out_gt, out_lt, out_eq;

comparator_16bit f(a[15:0], b[15:0], in_gt, in_lt, in_eq, pre_out_gt, pre_out_lt, pre_out_eq),
                 s(a[31:16], b[31:16], pre_out_gt, pre_out_lt, pre_out_eq, out_gt, out_lt, out_eq);
endmodule


module comparator (a, b, out_gt, out_lt, out_eq);
input [31:0] a, b;
wire in_gt = 1'b0;
wire in_eq = 1'b1;
wire in_lt = 1'b0;
output out_gt, out_lt, out_eq;

comparator_32bit c(a, b, in_gt, in_lt, in_eq, out_gt, out_lt, out_eq);
endmodule


module comparator_signed(a,b, out_gt, out_lt, out_eq);
input [31:0] a, b;
output out_gt, out_lt, out_eq;

wire a_s = a[31];
wire b_s = b[31];

wire sel;

xor(sel, a_s, b_s);

comparator c(a, b, gt_m, lt_m, out_eq);

mux_2_to_1 mux1(gt_m, b_s, sel, out_gt);
mux_2_to_1 mux2(lt_m, a_s, sel, out_lt);

endmodule
