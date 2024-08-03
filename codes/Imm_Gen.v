module Imm_Gen(
	data_i,
	data_o
);

input  signed [31:0] data_i;
output signed [31:0] data_o;

wire signed [11:0] imm;

assign imm = (data_i[6:0] == 7'b0010011 && data_i[14:12] == 3'b000)? data_i[31:20] :
			 (data_i[6:0] == 7'b0010011 && data_i[14:12] == 3'b101)? data_i[24:20] :
			 (data_i[6:0] == 7'b0000011)?                            data_i[31:20] :
			 (data_i[6:0] == 7'b0100011)?                            {data_i[31:25], data_i[11:7]}:
			 {data_i[31], data_i[7], data_i[30:25], data_i[11:8]};

assign data_o = imm;


endmodule
