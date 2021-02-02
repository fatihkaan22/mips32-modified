`define DELAY 20

module shift_left_2_testbench();

reg [31:0] a;
wire [31:0] out;

shift_left_2 s(a [31:0],out [31:0]);

initial begin
a = 32'b00000000_00000000_00000000_10101010;
#`DELAY;
a = 32'b00111111_00000000_00000000_10101010;
#`DELAY;
end

initial
begin
$monitor("time = %d, a =%32b, out=%32b", $time, a, out);
end

endmodule
