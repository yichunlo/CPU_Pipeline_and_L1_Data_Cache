module Pipeline_Register_IFID(
	clk_i, 
	rst_i,
	data_i,
	stall_i, 
	MemStall_i,
	flush_i,
	pc_i,
	pc_o,
	data_o
);

// Ports
input 				clk_i; 
input           	rst_i;
input  	[31:0]		data_i;
input 				stall_i; 
input				MemStall_i;
input 				flush_i;
input  	[31:0] 		pc_i;
output 	[31:0] 		pc_o;
output 	[31:0] 		data_o;

// Wires & Registers
reg 	[31:0] 		data_o;
reg 	[31:0] 		pc_o;


always@(posedge clk_i or posedge rst_i) begin
	if(rst_i) begin
        pc_o   		<= 32'b0;
        data_o 		<= 32'b0;

    end  
    else begin
    	data_o  = (stall_i || MemStall_i)? data_o : 
		          (flush_i)? 32'b0010011 : data_i;
		pc_o 	= pc_i;

	end
end

endmodule