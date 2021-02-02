`define DELAY 20

module sign_extend_testbench();

reg [15:0] a;
wire [31:0] out;

sign_extend_16_32 s(a [15:0],out[31:0]);

initial begin
a = 32'b00000000_10101010;
#`DELAY;
a = 32'b10111111_11111111;
#`DELAY;
end

initial
begin
$monitor("time = %2d, a =%16b, out=%32b", $time, a, out);
end


endmodule
