`define DELAY 20

module mux_2_to_1_testbench();

reg [31:0] a, b;
reg sel;
wire [31:0] out;

mux_2_to_1_32bit mux_test(a [31:0],b [31:0],sel,out[31:0]);

initial begin
a = 32'b00110000_00000000_00000000_10101010;
b = 32'b00000000_00000000_11111111_11111111;
sel = 1'b0;
#`DELAY;
sel = 1'b1;
#`DELAY;
end

initial
begin
$monitor("time = %2d, a =%32b, b=%32b, sel=%1b, out=%32b", $time, a, b, sel, out);
end


endmodule
