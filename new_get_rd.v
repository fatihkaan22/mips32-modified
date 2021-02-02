// in: $rs OP $rt,  out 1 or 2 or 3

//$rs <= $rs + $rt 
//if($rs + $rt == 0) 
//$rd <= 1 
//else if($rs + $rt < 0) 
//$rd <= 2 
//else 
//$rd <= 3 

module new_get_rd(in, out);
input [31:0] in;
output [31:0] out;

wire gt, eq, lt;
wire [31:0] mux1_res;

comparator_signed get_result(in[31:0], 32'b0, gt, lt, eq);

mux_2_to_1_32bit mux1(32'd3, 32'd2, lt, mux1_res[31:0]);

mux_2_to_1_32bit mux2(mux1_res[31:0], 32'd1, eq, out[31:0]);
 
endmodule
