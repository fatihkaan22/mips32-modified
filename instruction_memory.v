module instruction_memory(instruction, read_address);
output [31:0] instruction;
input [11:0] read_address;
reg [31:0] instructions [4095:0]; // 2^12 - 1

assign instruction = instructions[read_address[11:0]];

endmodule
