// for lui instruction

module load_upper_16(out,in);

input [15:0] in;
output [31:0] out;

buf_16_bit msb16(out[31:16], in[15:0]),
           lsb16(out[15:0], {32{1'b0}});


endmodule
