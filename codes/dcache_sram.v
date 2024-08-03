module dcache_sram
(
    clk_i,
    rst_i,
    addr_i,
    tag_i,
    data_i,
    enable_i,
    write_i,
    tag_o,
    data_o,
    hit_o
);

// I/O Interface from/to controller
input              clk_i;
input              rst_i;
input    [3:0]     addr_i;
input    [24:0]    tag_i;
input    [255:0]   data_i;
input              enable_i;
input              write_i;

output   [24:0]    tag_o;
output   [255:0]   data_o;
output             hit_o;


// Memory
reg      [24:0]    tag [0:15][0:1];    
reg      [255:0]   data[0:15][0:1];
reg                LRU_bit[0:15];   //0 is left, 1 is right  
wire      [24:0]   output_tag;    
wire      [255:0]  output_data;
integer            i, j;

wire               left_hit;
wire               right_hit;
wire               LRU_now;

wire     [24:0]    tag_0_0;

// Write Data      
// 1. Write hit
// 2. Read miss: Read from memory
assign left_hit  = ((tag_i[22:0] == tag[addr_i][0][22:0]) && tag[addr_i][0][24]);
assign right_hit = ((tag_i[22:0] == tag[addr_i][1][22:0]) && tag[addr_i][1][24]);
assign LRU_now   = LRU_bit[addr_i];
assign tag_0_0   = tag[0][0];

always@(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        for (i = 0; i < 16; i = i + 1) begin
            LRU_bit[i] <= 0;
            for (j = 0; j < 2;j = j + 1) begin
                tag[i][j] <= 25'b0;
                data[i][j] <= 256'b0;
            end
        end
    end
    if (enable_i && write_i) begin
        // TODO: Handle your write of 2-way associative cache + LRU here
        
        if (left_hit) begin      //left hit
            tag[addr_i][0][23] <= 1;         // set dirty bit
            data[addr_i][0]    <= data_i;    // set data
            LRU_bit[addr_i]    <= 1;         // set LRU to right

        end
        if (right_hit) begin //right hit
            tag[addr_i][1][23] <= 1;         // set dirty bit
            data[addr_i][1]    <= data_i;    // set data
            LRU_bit[addr_i]    <= 0;         // set LRU to left

        end
        if ( !left_hit && !right_hit ) begin

            tag[addr_i][LRU_bit[addr_i]] <= tag_i;               // set tag
            data[addr_i][LRU_bit[addr_i]] <= data_i;             // set data
            LRU_bit[addr_i] <= !LRU_bit[addr_i];                 // set LRU to another side

        end

    end
end

assign output_tag  = (left_hit)?                                     tag[addr_i][0]:
                     (right_hit)?                                    tag[addr_i][1]:
                     (tag[addr_i][LRU_bit[addr_i]][24:23] == 2'b11)? tag[addr_i][LRU_bit[addr_i]] : output_tag;
assign output_data = (left_hit)?                                     data[addr_i][0]:
                     (right_hit)?                                    data[addr_i][1]:
                     (tag[addr_i][LRU_bit[addr_i]][24:23] == 2'b11)? data[addr_i][LRU_bit[addr_i]]: output_data;


// Read Data      
// TODO: tag_o=? data_o=? hit_o=?
assign tag_o  = (tag[addr_i][LRU_bit[addr_i]][24:23] == 2'b11)? output_tag:
                (enable_i && !write_i)? tag_i : output_tag;
assign data_o = output_data;
                // (enable_i && !write_i)? data_i: output_data;
assign hit_o  = (left_hit || right_hit);

endmodule
