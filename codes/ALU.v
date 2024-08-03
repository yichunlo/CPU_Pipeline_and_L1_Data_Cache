module ALU
(
    data1_i,
    data2_i,
    ALUCtrl_i,
    data_o,
    Zero_o
);

// Ports
input  signed [31:0] data1_i;
input  signed [31:0] data2_i;
input         [3:0]  ALUCtrl_i;
output signed [31:0] data_o;
output               Zero_o;

// Wires & Registers
assign Zero_o = 0;
assign data_o = (ALUCtrl_i == 4'b0000)? data1_i  &  data2_i :
                (ALUCtrl_i == 4'b0001)? data1_i  ^  data2_i :
                (ALUCtrl_i == 4'b0010)? data1_i <<< data2_i :
                (ALUCtrl_i == 4'b0011)? data1_i  +  data2_i :
                (ALUCtrl_i == 4'b0100)? data1_i  -  data2_i :
                (ALUCtrl_i == 4'b0101)? data1_i  *  data2_i :
                (ALUCtrl_i == 4'b0110)? data1_i  +  data2_i :
                (ALUCtrl_i == 4'b0111)? data1_i >>> data2_i[4:0]:
                (ALUCtrl_i == 4'b1000)? data1_i  +  data2_i :
                data1_i  +  data2_i; 


endmodule
