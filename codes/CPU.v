module CPU
(
    clk_i, 
    rst_i,
    start_i,
    mem_data_i,
    mem_ack_i,
    mem_data_o,
    mem_addr_o,
    mem_enable_o,
    mem_write_o
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;
// Project2 New!!!
input   [255:0]     mem_data_i;
input               mem_ack_i;
output  [255:0]     mem_data_o;
output  [31:0]      mem_addr_o;
output              mem_enable_o;
output              mem_write_o;


Control Control(
    .Op_i       (),
    .NoOp_i     (),
    .ALUOp_o    (),
    .ALUSrc_o   (),
    .RegWrite_o (),
    .MemtoReg_o (),
    .MemRead_o  (),
    .MemWrite_o (),
    .Branch_o   () 
);

Adder Add_PC(
    .data1_in   (),
    .data2_in   (),
    .data_o     ()
);

PC PC(
    .clk_i      (),
    .rst_i      (),
    .start_i    (),
    .stall_i    (), //Project2 new!!!
    .PCWrite_i  (),
    .pc_i       (),
    .pc_o       ()
);

Instruction_Memory Instruction_Memory(
    .addr_i     (), 
    .instr_o    ()
);

Registers Registers(
    .clk_i      (),
    .RS1addr_i  (),
    .RS2addr_i  (),
    .RDaddr_i   (), 
    .RDdata_i   (),
    .RegWrite_i (), 
    .RS1data_o  (), 
    .RS2data_o  () 
);

MUX32 MUX_ALUSrc(
    .data1_i    (),
    .data2_i    (),
    .select_i   (),
    .data_o     ()
);

Imm_Gen Imm_Gen(
    .data_i     (),
    .data_o     ()
);
  
ALU ALU(
    .data1_i    (),
    .data2_i    (),
    .ALUCtrl_i  (),
    .data_o     (),
    .Zero_o     ()
);

ALU_Control ALU_Control(
    .funct7_i   (),
    .funct3_i   (),
    .ALUOp_i    (),
    .ALUCtrl_o  ()
);

// Project2 New!!!
/* 
Data_Memory Data_Memory(
    .clk_i      (), 
    .addr_i     (), 
    .MemRead_i  (),
    .MemWrite_i (),
    .data_i     (),
    .data_o     ()
);
*/

MUX32 MUX_toReg(
    .data1_i    (),
    .data2_i    (),
    .select_i   (),
    .data_o     ()
);

// New Module
// Blue

MUX_Forward MUX_ForwardA(
    .data1_i    (),
    .data2_i    (),
    .data3_i    (),
    .data4_i    (),
    .select_i   (),
    .data_o     ()
);

MUX_Forward MUX_ForwardB(
    .data1_i    (),
    .data2_i    (),
    .data3_i    (),
    .data4_i    (),
    .select_i   (),
    .data_o     ()
);

Forwarding_Unit Forwarding_Unit(
    .EXRs1_i        (),
    .EXRs2_i        (),
    .WBRd_i         (),
    .WBRegWrite_i   (),
    .MEMRd_i        (),
    .MEMRegWrite_i  (),
    .ForwardA_o     (),
    .ForwardB_o     ()
);

//Orange

Hazard_Detection_Unit Hazard_Detection_Unit(
    .MemRead_i  (),
    .RDdata_i   (),
    .RS1data_i  (),
    .RS2data_i  (),
    .NoOp_o     (),
    .Stall_o    (),
    .PCWrite_o  ()
);

MUX32 MUX_PC(
    .data1_i    (),
    .data2_i    (),
    .select_i   (),
    .data_o     ()
);

Adder Add_Branch(
    .data1_in   (),
    .data2_in   (),
    .data_o     ()
);

//Green

Pipeline_Register_IFID Pipeline_Register_IFID(
    .clk_i          (),
    .rst_i          (),
    .data_i         (),
    .stall_i        (),
    .MemStall_i     (), //Project2 new!!!
    .flush_i        (),
    .pc_i           (),
    .data_o         (),
    .pc_o           ()
);

Pipeline_Register_IDEX Pipeline_Register_IDEX(
    .clk_i          (),
    .RegWrite_i     (),
    .MemtoReg_i     (),
    .MemRead_i      (),
    .MemWrite_i     (),
    .ALUOp_i        (),
    .ALUSrc_i       (),
    .read_data_1_i  (),
    .read_data_2_i  (),
    .imm_i          (),
    .funct7_i       (),
    .funct3_i       (),
    .rs1_i          (), 
    .rs2_i          (), 
    .rd_i           (),
    .MemStall_i     (), //Project2 new!!!
    .RegWrite_o     (),
    .MemtoReg_o     (),
    .MemRead_o      (),
    .MemWrite_o     (),
    .ALUOp_o        (),
    .ALUSrc_o       (),
    .read_data_1_o  (),
    .read_data_2_o  (),
    .imm_o          (),
    .funct7_o       (),
    .funct3_o       (),
    .rs1_o          (),      
    .rs2_o          (), 
    .rd_o           ()
);

Pipeline_Register_EXMEM Pipeline_Register_EXMEM(
    .clk_i          (),
    .RegWrite_i     (),
    .MemtoReg_i     (),
    .MemRead_i      (),
    .MemWrite_i     (),
    .ALU_result_i   (),
    .read_data_2_i  (),
    .rd_i           (),
    .MemStall_i     (), //Project2 new!!!
    .RegWrite_o     (),
    .MemtoReg_o     (),
    .MemRead_o      (),
    .MemWrite_o     (),
    .ALU_result_o   (),
    .read_data_2_o  (),
    .rd_o           ()
);

Pipeline_Register_MEMWB Pipeline_Register_MEMWB(
    .clk_i          (),
    .RegWrite_i     (),
    .MemtoReg_i     (),
    .ALU_result_i   (),
    .read_data_i    (),
    .rd_i           (),
    .MemStall_i     (), //Project2 new!!!
    .RegWrite_o     (),
    .MemtoReg_o     (),
    .ALU_result_o   (),
    .read_data_o    (),
    .rd_o           ()
);

// Project2 New!!!
// Data Caches
dcache_controller dcache(
    .clk_i          (),
    .rst_i          (),
    .mem_data_i     (), 
    .mem_ack_i      (),     
    .mem_data_o     (), 
    .mem_addr_o     (),     
    .mem_enable_o   (), 
    .mem_write_o    (), 
    .cpu_data_i     (), 
    .cpu_addr_i     (),     
    .cpu_MemRead_i  (), 
    .cpu_MemWrite_i (), 
    .cpu_data_o     (), 
    .cpu_stall_o    ()
);


// Wires

//Control
assign Control.Op_i   = Pipeline_Register_IFID.data_o[6:0];
assign Control.NoOp_i = Hazard_Detection_Unit.NoOp_o;

//Add_PC
assign Add_PC.data1_in = PC.pc_o;
assign Add_PC.data2_in = 4;

//PC
assign PC.clk_i     = clk_i;
assign PC.rst_i     = rst_i;
assign PC.start_i   = start_i;
assign PC.stall_i   = dcache.cpu_stall_o;        //Project2 New!!!
assign PC.PCWrite_i = Hazard_Detection_Unit.PCWrite_o;
assign PC.pc_i      = MUX_PC.data_o;


//Instruction_Memory
assign Instruction_Memory.addr_i = PC.pc_o;

//Registers
assign Registers.clk_i      = clk_i;
assign Registers.RS1addr_i  = Pipeline_Register_IFID.data_o[19:15];
assign Registers.RS2addr_i  = Pipeline_Register_IFID.data_o[24:20];
assign Registers.RDaddr_i   = Pipeline_Register_MEMWB.rd_o;
assign Registers.RDdata_i   = MUX_toReg.data_o;
assign Registers.RegWrite_i = Pipeline_Register_MEMWB.RegWrite_o;

//MUX_ALUSrc
assign MUX_ALUSrc.data1_i   = MUX_ForwardB.data_o;
assign MUX_ALUSrc.data2_i   = Pipeline_Register_IDEX.imm_o;
assign MUX_ALUSrc.select_i  = Pipeline_Register_IDEX.ALUSrc_o;

//Imm_Gen
assign Imm_Gen.data_i = Pipeline_Register_IFID.data_o;

//ALU
assign ALU.data1_i   = MUX_ForwardA.data_o;
assign ALU.data2_i   = MUX_ALUSrc.data_o;
assign ALU.ALUCtrl_i = ALU_Control.ALUCtrl_o;

//ALU_Control
assign ALU_Control.funct7_i = Pipeline_Register_IDEX.funct7_o;
assign ALU_Control.funct3_i = Pipeline_Register_IDEX.funct3_o;
assign ALU_Control.ALUOp_i  = Pipeline_Register_IDEX.ALUOp_o;

// Project2 New!!!
//Data_Memory
/*
assign Data_Memory.clk_i      = clk_i;
assign Data_Memory.addr_i     = Pipeline_Register_EXMEM.ALU_result_o;
assign Data_Memory.MemRead_i  = Pipeline_Register_EXMEM.MemRead_o;
assign Data_Memory.MemWrite_i = Pipeline_Register_EXMEM.MemWrite_o;
assign Data_Memory.data_i     = Pipeline_Register_EXMEM.read_data_2_o;
*/

//MUX_toReg
assign MUX_toReg.data1_i  = Pipeline_Register_MEMWB.ALU_result_o;
assign MUX_toReg.data2_i  = Pipeline_Register_MEMWB.read_data_o;
assign MUX_toReg.select_i = Pipeline_Register_MEMWB.MemtoReg_o;


//New Wires
//Blue
//MUX_ForwardA
assign MUX_ForwardA.data1_i  = Pipeline_Register_IDEX.read_data_1_o;
assign MUX_ForwardA.data2_i  = MUX_toReg.data_o;
assign MUX_ForwardA.data3_i  = Pipeline_Register_EXMEM.ALU_result_o;
assign MUX_ForwardA.data4_i  = 0;
assign MUX_ForwardA.select_i = Forwarding_Unit.ForwardA_o;

//MUX_ForwardB
assign MUX_ForwardB.data1_i  = Pipeline_Register_IDEX.read_data_2_o;
assign MUX_ForwardB.data2_i  = MUX_toReg.data_o;
assign MUX_ForwardB.data3_i  = Pipeline_Register_EXMEM.ALU_result_o;
assign MUX_ForwardB.data4_i  = 0;
assign MUX_ForwardB.select_i = Forwarding_Unit.ForwardB_o;

//Forwarding_Unit
assign Forwarding_Unit.EXRs1_i       = Pipeline_Register_IDEX.rs1_o;
assign Forwarding_Unit.EXRs2_i       = Pipeline_Register_IDEX.rs2_o; 
assign Forwarding_Unit.WBRd_i        = Pipeline_Register_MEMWB.rd_o;
assign Forwarding_Unit.WBRegWrite_i  = Pipeline_Register_MEMWB.RegWrite_o;
assign Forwarding_Unit.MEMRd_i       = Pipeline_Register_EXMEM.rd_o;
assign Forwarding_Unit.MEMRegWrite_i = Pipeline_Register_EXMEM.RegWrite_o;

//Orange
//Hazard_Detection_Unit
assign Hazard_Detection_Unit.MemRead_i = Pipeline_Register_IDEX.MemRead_o;
assign Hazard_Detection_Unit.RDdata_i  = Pipeline_Register_IDEX.rd_o;
assign Hazard_Detection_Unit.RS1data_i = Pipeline_Register_IFID.data_o[19:15];
assign Hazard_Detection_Unit.RS2data_i = Pipeline_Register_IFID.data_o[24:20];

//MUX_PC
assign MUX_PC.data1_i  = Add_PC.data_o;
assign MUX_PC.data2_i  = Add_Branch.data_o;
assign MUX_PC.select_i = (Registers.RS1data_o == Registers.RS2data_o) && Control.Branch_o;

//Add_Branch
assign Add_Branch.data1_in = (Imm_Gen.data_o << 1);
assign Add_Branch.data2_in = Pipeline_Register_IFID.pc_o;

//Green
//Pipeline_Register_IFID
assign Pipeline_Register_IFID.clk_i         = clk_i;
assign Pipeline_Register_IFID.rst_i         = rst_i;
assign Pipeline_Register_IFID.data_i        = Instruction_Memory.instr_o;
assign Pipeline_Register_IFID.stall_i       = Hazard_Detection_Unit.Stall_o;
assign Pipeline_Register_IFID.MemStall_i    = dcache.cpu_stall_o;    // Project2 New!!!
assign Pipeline_Register_IFID.flush_i       = (Registers.RS1data_o == Registers.RS2data_o) && Control.Branch_o;
assign Pipeline_Register_IFID.pc_i          = PC.pc_o;

//Pipeline_Register_IDEX
assign Pipeline_Register_IDEX.clk_i         = clk_i;
assign Pipeline_Register_IDEX.rst_i         = rst_i;
assign Pipeline_Register_IDEX.RegWrite_i    = Control.RegWrite_o;
assign Pipeline_Register_IDEX.MemtoReg_i    = Control.MemtoReg_o;
assign Pipeline_Register_IDEX.MemRead_i     = Control.MemRead_o;
assign Pipeline_Register_IDEX.MemWrite_i    = Control.MemWrite_o;
assign Pipeline_Register_IDEX.ALUOp_i       = Control.ALUOp_o;
assign Pipeline_Register_IDEX.ALUSrc_i      = Control.ALUSrc_o;
assign Pipeline_Register_IDEX.read_data_1_i = Registers.RS1data_o;
assign Pipeline_Register_IDEX.read_data_2_i = Registers.RS2data_o;
assign Pipeline_Register_IDEX.imm_i         = Imm_Gen.data_o;
assign Pipeline_Register_IDEX.funct7_i      = Pipeline_Register_IFID.data_o[31:25];
assign Pipeline_Register_IDEX.funct3_i      = Pipeline_Register_IFID.data_o[14:12];
assign Pipeline_Register_IDEX.rs1_i         = Pipeline_Register_IFID.data_o[19:15];
assign Pipeline_Register_IDEX.rs2_i         = Pipeline_Register_IFID.data_o[24:20];
assign Pipeline_Register_IDEX.rd_i          = Pipeline_Register_IFID.data_o[11:7];
assign Pipeline_Register_IDEX.MemStall_i    = dcache.cpu_stall_o;    // Project2 New!!!

//Pipeline_Register_EXMEM
assign Pipeline_Register_EXMEM.clk_i         = clk_i;
assign Pipeline_Register_EXMEM.rst_i         = rst_i;
assign Pipeline_Register_EXMEM.RegWrite_i    = Pipeline_Register_IDEX.RegWrite_o;
assign Pipeline_Register_EXMEM.MemtoReg_i    = Pipeline_Register_IDEX.MemtoReg_o;
assign Pipeline_Register_EXMEM.MemRead_i     = Pipeline_Register_IDEX.MemRead_o;
assign Pipeline_Register_EXMEM.MemWrite_i    = Pipeline_Register_IDEX.MemWrite_o;
assign Pipeline_Register_EXMEM.ALU_result_i  = ALU.data_o;
assign Pipeline_Register_EXMEM.read_data_2_i = MUX_ForwardB.data_o;
assign Pipeline_Register_EXMEM.rd_i          = Pipeline_Register_IDEX.rd_o;
assign Pipeline_Register_EXMEM.MemStall_i    = dcache.cpu_stall_o;   // Project2 New!!!


//Pipeline_Register_MEMWB
assign Pipeline_Register_MEMWB.clk_i        = clk_i;
assign Pipeline_Register_MEMWB.rst_i        = rst_i;
assign Pipeline_Register_MEMWB.RegWrite_i   = Pipeline_Register_EXMEM.RegWrite_o;
assign Pipeline_Register_MEMWB.MemtoReg_i   = Pipeline_Register_EXMEM.MemtoReg_o;
assign Pipeline_Register_MEMWB.ALU_result_i = Pipeline_Register_EXMEM.ALU_result_o;
assign Pipeline_Register_MEMWB.read_data_i  = dcache.cpu_data_o;     // Project2 New!!!
assign Pipeline_Register_MEMWB.rd_i         = Pipeline_Register_EXMEM.rd_o;
assign Pipeline_Register_MEMWB.MemStall_i   = dcache.cpu_stall_o;    // Project2 New!!!


// Project2 New!!!
//dcache
assign dcache.clk_i              = clk_i;
assign dcache.rst_i              = rst_i;
assign dcache.mem_data_i         = mem_data_i;
assign dcache.mem_ack_i          = mem_ack_i;
assign dcache.cpu_data_i         = Pipeline_Register_EXMEM.read_data_2_o;
assign dcache.cpu_addr_i         = Pipeline_Register_EXMEM.ALU_result_o;
assign dcache.cpu_MemRead_i      = Pipeline_Register_EXMEM.MemRead_o;
assign dcache.cpu_MemWrite_i     = Pipeline_Register_EXMEM.MemWrite_o;

//CPU output
assign mem_data_o   = dcache.mem_data_o;
assign mem_addr_o   = dcache.mem_addr_o;
assign mem_enable_o = dcache.mem_enable_o;
assign mem_write_o  = dcache.mem_write_o;


endmodule

