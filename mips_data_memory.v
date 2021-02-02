module mips_data_memory(read_data, address, write_data, signal_mem_write, signal_mem_read, clock);
input [15:0] address;
output reg [31:0] read_data;
input [31:0] write_data;
input signal_mem_write, signal_mem_read, clock;
reg [31:0] data [65535:0];  // 2^16-1


always @(posedge clock) begin
	if (signal_mem_write == 1'b1) begin
		data[address] = write_data;
	end
end

always @(negedge clock) begin
	if (signal_mem_read == 1'b1) begin
		read_data = data[address[15:0]];
	end
end


endmodule