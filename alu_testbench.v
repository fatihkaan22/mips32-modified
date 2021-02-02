`define DELAY 20
module alu_testbench();

reg [31:0] a, b;
reg [2:0] sel;
wire [31:0] out;
wire zero;

alu_32bit alu_test(a [31:0],b [31:0],sel,out[31:0], zero);

initial begin
// add test
a = 32'd2;
b = 32'd6;
sel = 3'b100;
#`DELAY;
// add w/overflow test
a = 32'd2147483647;
b = 32'd2147483647;
sel = 3'b100;
#`DELAY;
// sub test
a = 32'd15;
b = 32'd3;
sel = 3'b101;
#`DELAY;
// sub test
a = 32'd0;
b = 32'd2147483647;
sel = 3'b101;
#`DELAY;
// and test
a = 32'b00000000_00000000_00000000_10101010;
b = 32'b00000000_00000000_11111111_11111111;
sel = 3'b000;
#`DELAY;
// or test
a = 32'b00000000_00000000_00000000_10101010;
b = 32'b00000000_00000000_11111111_11111111;
sel = 3'b001;
#`DELAY;
// xor test
a = 32'b00000000_00000000_00000000_10101010;
b = 32'b00000000_00000000_11111111_11111111;
sel = 3'b110;
#`DELAY;
// add test w/zero out
a = 32'd2;
b = 32'd2;
sel = 3'b101;
#`DELAY;
a = 32'd5;
b = 32'd8;
sel = 3'b101;
#`DELAY;
end

initial
begin
$monitor("time = %d, a =%32b, b=%32b, sel=%3b, out=%32b, zero=%1b", $time, a, b, sel, out, zero);
end


endmodule
