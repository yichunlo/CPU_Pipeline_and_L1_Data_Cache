module Hazard_Detection_Unit(
	MemRead_i,	
	RDdata_i,
	RS1data_i,
	RS2data_i,
	NoOp_o,
	Stall_o,
	PCWrite_o
);

input        MemRead_i;
input  [4:0] RDdata_i;
input  [4:0] RS1data_i;
input  [4:0] RS2data_i;
output       NoOp_o;
output       Stall_o;
output       PCWrite_o;

assign NoOp_o    =  ( MemRead_i && (RDdata_i == RS1data_i || RDdata_i == RS2data_i) );
assign Stall_o   =  ( MemRead_i && (RDdata_i == RS1data_i || RDdata_i == RS2data_i) );
assign PCWrite_o = !( MemRead_i && (RDdata_i == RS1data_i || RDdata_i == RS2data_i) );


endmodule
