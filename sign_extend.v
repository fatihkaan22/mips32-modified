module buf_2_bit(out, a);
input [1:0] a;
output [1:0] out;

buf f(out[0], a[0]),
    s(out[1], a[1]);
endmodule

module buf_4_bit(out, a);
input [3:0] a;
output [3:0] out;

buf_2_bit f(out[1:0], a[1:0]),
          s(out[3:2], a[3:2]);
endmodule

module buf_8_bit(out, a);
input [7:0] a;
output [7:0] out;

buf_4_bit f(out[3:0], a[3:0]),
          s(out[7:4], a[7:4]);
endmodule

module buf_16_bit(out, a);
input [15:0] a;
output [15:0] out;

buf_8_bit f(out[7:0], a[7:0]),
          s(out[15:8], a[15:8]);
endmodule


module sign_extend_16_32(i,o);
input [15:0] i;
output [31:0] o;
wire sign = i[15];


buf_16_bit f(o[15:0], i[15:0]),
           s(o[31:16], {16 {sign}});


endmodule
