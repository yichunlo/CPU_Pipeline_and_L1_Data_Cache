module Control
(
    Op_i,
    NoOp_i,
    ALUOp_o,
    ALUSrc_o,
    RegWrite_o,
    MemtoReg_o,
    MemRead_o,
    MemWrite_o,
    Branch_o
);

// Ports
input  [6:0] Op_i;
input        NoOp_i;
output [1:0] ALUOp_o;
output       ALUSrc_o;
output       RegWrite_o;
output       MemtoReg_o;
output       MemRead_o;
output       MemWrite_o;
output       Branch_o;

// Wires & Registers
assign ALUOp_o    = Op_i[5:4]; //add is 11, addi is 01, lw is 00, sw is 10
assign ALUSrc_o   = (Op_i == 7'b0100011)? 1 : !Op_i[5];
assign RegWrite_o = (NoOp_i)? 0 : !(Op_i == 7'b0100011 || Op_i == 7'b1100011);
assign MemtoReg_o = (NoOp_i)? 0 : (Op_i == 7'b0000011);
assign MemRead_o  = (NoOp_i)? 0 : (Op_i == 7'b0000011);
assign MemWrite_o = (NoOp_i)? 0 : (Op_i == 7'b0100011);
assign Branch_o   = (NoOp_i)? 0 : (Op_i == 7'b1100011);

endmodule
