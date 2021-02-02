`define DELAY 20

module comparator_testbench();

reg [31:0] a, b;

comparator_signed c_test(a, b, out_gt, out_lt, out_eq);

initial begin

a = 32'd12;
b = 32'd12;
#`DELAY;
a = 32'd17;
b = 32'd22;
#`DELAY;
a = 32'd3;
b = 32'd1;
#`DELAY;
a = -32'd12;
b = -32'd12;
#`DELAY;
a = -32'd17;
b = -32'd22;
#`DELAY;
a = -32'd3;
b = 32'd1;
#`DELAY;
a = 32'd3;
b = -32'd1;
#`DELAY;
end

initial
begin
$monitor("time = %2d, a=%d, b=%d, out_gt=%b, out_lt=%b, out_eq=%b, ", $time, a, b, out_gt, out_lt, out_eq);
end




endmodule

