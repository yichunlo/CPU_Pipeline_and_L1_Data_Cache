module Adder
(
    data1_in,
    data2_in,
    data_o
);

// Ports
input  [31:0] data1_in;
input  [31:0] data2_in;
output [31:0] data_o;

// Wires & Registers
assign data_o = data1_in + data2_in;

endmodule
