module mips_registers
( read_data_1, read_data_2, write_data, write_data2, read_reg_1, read_reg_2, write_reg, write_reg2, signal_reg_write, signal_reg_write2, clk );

	output [31:0] read_data_1, read_data_2;
	input [31:0] write_data, write_data2;
	input [4:0] read_reg_1, read_reg_2, write_reg, write_reg2;
	input signal_reg_write, signal_reg_write2, clk;
	
	reg [31:0] registers [31:0];
	
	assign read_data_1 = registers[read_reg_1];
	assign read_data_2 = registers[read_reg_2];
	
	always @(posedge clk) begin
		if(signal_reg_write && write_reg != 5'b0) begin // write signal and zero register control
			registers[write_reg]<=write_data;
		end
		if(signal_reg_write2 && write_reg2 != 5'b0) begin
			registers[write_reg2]<=write_data2;
		end

	end
	
endmodule
