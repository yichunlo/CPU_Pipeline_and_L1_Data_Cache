module Forwarding_Unit(
	EXRs1_i,
	EXRs2_i,
	WBRd_i,
	WBRegWrite_i,
	MEMRd_i,
	MEMRegWrite_i,
	ForwardA_o,
	ForwardB_o
);

// port
input  [4:0] EXRs1_i;
input  [4:0] EXRs2_i;
input  [4:0] WBRd_i;
input        WBRegWrite_i;
input  [4:0] MEMRd_i;
input        MEMRegWrite_i;
output [1:0] ForwardA_o;
output [1:0] ForwardB_o;

assign ForwardA_o = (MEMRegWrite_i && MEMRd_i != 0 && MEMRd_i == EXRs1_i)? 2'b10 :
					(WBRegWrite_i  && WBRd_i  != 0 && WBRd_i  == EXRs1_i)? 2'b01 : 00;
assign ForwardB_o = (MEMRegWrite_i && MEMRd_i != 0 && MEMRd_i == EXRs2_i)? 2'b10 :
					(WBRegWrite_i  && WBRd_i  != 0 && WBRd_i  == EXRs2_i)? 2'b01 : 00;

endmodule