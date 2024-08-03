module ALU_Control
(
    funct7_i,
    funct3_i,
    ALUOp_i,
    ALUCtrl_o
);

// Ports
input  [6:0] funct7_i;
input  [2:0] funct3_i;
input  [1:0] ALUOp_i;
output [3:0] ALUCtrl_o;

// Wires & Registers
assign ALUCtrl_o =  (funct7_i == 7'b0000000 && funct3_i == 3'b111 && ALUOp_i == 2'b11)? 4'b0000 : //and
                    (funct7_i == 7'b0000000 && funct3_i == 3'b100 && ALUOp_i == 2'b11)? 4'b0001 : //xor
                    (funct7_i == 7'b0000000 && funct3_i == 3'b001 && ALUOp_i == 2'b11)? 4'b0010 : //sll
                    (funct7_i == 7'b0000000 && funct3_i == 3'b000 && ALUOp_i == 2'b11)? 4'b0011 : //add
                    (funct7_i == 7'b0100000 && funct3_i == 3'b000 && ALUOp_i == 2'b11)? 4'b0100 : //sub
                    (funct7_i == 7'b0000001 && funct3_i == 3'b000 && ALUOp_i == 2'b11)? 4'b0101 : //mul
                    (                          funct3_i == 3'b000 && ALUOp_i == 2'b01)? 4'b0110 : //addi
                    (                          funct3_i == 3'b010 && ALUOp_i == 2'b00)? 4'b1000 : //lw
                    (                          funct3_i == 3'b010 && ALUOp_i == 2'b10)? 4'b1001 : //sw
                    4'b0111 ; //srai

endmodule
