`define DELAY 20

module new_get_rd_testbench();

reg [31:0] a;
wire [31:0] out;

new_get_rd g(a [31:0],out [31:0]);

initial begin
a = 32'd3;
#`DELAY;
a = 32'd0;
#`DELAY;
a = -32'd2;
#`DELAY;
end

initial
begin
$monitor("time = %d, a =%32b, out=%32b", $time, a, out);
end

endmodule
