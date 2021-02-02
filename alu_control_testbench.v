`define DELAY 20
module alu_ctr_testbench();

reg [1:0] o; // aluop
reg [5:0] f; // function field
wire [2:0] alu_ctr;
wire jr;

alu_control test(alu_ctr, jr, f, o);

initial begin
// lw/sw test
f = 6'b010101; // xxxxxx
o = 2'b00;
#`DELAY;
// lw/sw test
f = 6'b110111; // xxxxxx
o = 2'b00;
#`DELAY;
// lw/sw test
f = 6'b000000; // xxxxxx
o = 2'b00;
#`DELAY;
// beq/bne test
f = 6'b000000; // xxxxxx
o = 2'b01;
#`DELAY;
// addn test
f = 6'b100000;
o = 2'b10;
#`DELAY;
// subn test
f = 6'b100010;
o = 2'b10;
#`DELAY;
// andn test
f = 6'b100100;
o = 2'b10;
#`DELAY;
// orn test
f = 6'b100101;
o = 2'b10;
#`DELAY;
// xorn test
f = 6'b100110;
o = 2'b10;
#`DELAY;
// ori test
f = 6'b100010; // xxxxxx
o = 2'b11;
#`DELAY;
// jr test
f = 6'b001000; // xxxxxx
o = 2'b10;
#`DELAY;
end

initial
begin
$monitor("time = %d, f=%6b, o=%2b, out=%3b, jr=%b", $time, f, o, alu_ctr, jr);
end

endmodule
