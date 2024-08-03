module MUX32
(
    data1_i,
    data2_i,
    select_i,
    data_o
);

// Ports
input  signed [31:0] data1_i;
input  signed [31:0] data2_i;
input                select_i;
output signed [31:0] data_o;

// Wires & Registers
assign data_o = (select_i)? data2_i : data1_i;

endmodule
