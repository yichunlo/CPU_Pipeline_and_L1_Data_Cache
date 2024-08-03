module Pipeline_Register_EXMEM(
	input clk_i, 
	input rst_i,
	input RegWrite_i,
	input MemtoReg_i,
	input MemRead_i,
	input MemWrite_i,
	input [31:0] ALU_result_i,
	input [31:0] read_data_2_i,
	input [4:0] rd_i,
	input MemStall_i,				//Project2 new!!!
	output reg RegWrite_o,
	output reg MemtoReg_o,
	output reg MemRead_o,
	output reg MemWrite_o,
	output reg [31:0] ALU_result_o,
	output reg [31:0] read_data_2_o,
	output reg [4:0] rd_o
);


always@(posedge clk_i or posedge rst_i) begin
	if(rst_i) begin
        RegWrite_o    <= 0;
		MemtoReg_o    <= 0;
		MemRead_o     <= 0;
		MemWrite_o    <= 0;
		ALU_result_o  <= 0;
		read_data_2_o <= 0;
		rd_o          <= 0;
    end  
    else begin
		RegWrite_o    <= (MemStall_i)? RegWrite_o 		: RegWrite_i;
		MemtoReg_o    <= (MemStall_i)? MemtoReg_o 		: MemtoReg_i;
		MemRead_o     <= (MemStall_i)? MemRead_o 		: MemRead_i;
		MemWrite_o    <= (MemStall_i)? MemWrite_o 		: MemWrite_i;
		ALU_result_o  <= (MemStall_i)? ALU_result_o 	: ALU_result_i;
		read_data_2_o <= (MemStall_i)? read_data_2_o 	: read_data_2_i;
		rd_o          <= (MemStall_i)? rd_o 			: rd_i;

	end
end

endmodule