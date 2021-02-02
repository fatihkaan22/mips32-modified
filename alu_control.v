module alu_control(alu_ctr, jr, f, o);
input[1:0] o; // aluop
input [5:0] f; // function field
output [2:0] alu_ctr;
output jr;

wire f2_not, f1_not, f0_not, o1_not, o0_not, f5_not;
wire and1, and2, and3, and4, and5;
wire or1, or2;

not n0(f5_not, f[5]);
not n1(f2_not, f[2]);
not n2(f1_not, f[1]);
not n3(f0_not, f[0]);
not n4(o1_not, o[1]);
not n5(o0_not, o[0]);

//aluctr2 = o1' + o0' (f0' ( f2' + f1))
or o1(or1 ,f2_not, f[1]);
and a1(and1, or1, f0_not);
and a6(and5, and1, o0_not);
or o2(alu_ctr[2], and5, o1_not);

//aluctr1 = o1 o0' f2 f1 f0'
and a2(alu_ctr[1], o[1], o0_not, f[2], f[1], f0_not);

//aluctr0 = o0 + o1 (f2' f1 f0' + f2 f1' f0)
and a3(and2, f2_not, f[1], f0_not);
and a4(and3, f[2], f1_not, f[0]);
or o3(or2, and2, and3);
and a5(and4, or2, o[1]);
or o4(alu_ctr[0], o[0], and4);

//jr = o1 o0'f5'
and (jr, o[1], o0_not, f5_not);

endmodule
