module Pipeline_Register_IDEX(
	input clk_i,
	input rst_i,
	input RegWrite_i,
	input MemtoReg_i,
	input MemRead_i,
	input MemWrite_i,
	input [1:0] ALUOp_i,
	input ALUSrc_i,
	input [31:0] read_data_1_i,
	input [31:0] read_data_2_i,
	input [31:0] imm_i,
	input [6:0] funct7_i,
	input [2:0] funct3_i,
	input [4:0] rs1_i, 
	input [4:0] rs2_i, 
	input [4:0] rd_i,
	input MemStall_i,				//Project2 new!!!
	output reg RegWrite_o,
	output reg MemtoReg_o,
	output reg MemRead_o,
	output reg MemWrite_o,
	output reg [1:0] ALUOp_o,
	output reg ALUSrc_o,
	output reg [31:0] read_data_1_o,
	output reg [31:0] read_data_2_o,
	output reg [31:0] imm_o,
	output reg [6:0] funct7_o,
	output reg [2:0] funct3_o,
	output reg [4:0] rs1_o, 
	output reg [4:0] rs2_o, 
	output reg [4:0] rd_o
);

always@(posedge clk_i or posedge rst_i) begin
	if(rst_i) begin
        RegWrite_o  	 <= 0;
        MemtoReg_o		 <= 0;
        MemRead_o 		 <= 0;
        MemWrite_o		 <= 0;
		ALUOp_o       	 <= 0;
		ALUSrc_o      	 <= 0;
		read_data_1_o  	 <= 0;
		read_data_2_o  	 <= 0;
		imm_o          	 <= 0;
		funct7_o       	 <= 0;
		funct3_o       	 <= 0;
		rs1_o         	 <= 0;
		rs2_o         	 <= 0;
		rd_o          	 <= 0;

    end  
    else begin
		RegWrite_o    <= (MemStall_i)? RegWrite_o 		: RegWrite_i;
		MemtoReg_o    <= (MemStall_i)? MemtoReg_o 		: MemtoReg_i;
		MemRead_o     <= (MemStall_i)? MemRead_o  		: MemRead_i;
		MemWrite_o    <= (MemStall_i)? MemWrite_o    	: MemWrite_i;
		ALUOp_o       <= (MemStall_i)? ALUOp_o       	: ALUOp_i;
		ALUSrc_o      <= (MemStall_i)? ALUSrc_o 	    : ALUSrc_i;
		read_data_1_o <= (MemStall_i)? read_data_1_o 	: read_data_1_i;
		read_data_2_o <= (MemStall_i)? read_data_2_o 	: read_data_2_i;
		imm_o         <= (MemStall_i)? imm_o 			: imm_i;
		funct7_o      <= (MemStall_i)? funct7_o			: funct7_i;
		funct3_o      <= (MemStall_i)? funct3_o 		: funct3_i;
		rs1_o         <= (MemStall_i)? rs1_o			: rs1_i;
		rs2_o         <= (MemStall_i)? rs2_o 			: rs2_i;
		rd_o          <= (MemStall_i)? rd_o 			: rd_i;

	end
end

endmodule
