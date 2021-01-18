
//LISENCE
  import core_pkg::*;
  module core #(
    parameter alu::alu_feature_t FEATURES     = core_pkg::RV32D,
    parameter alu::implementation_t IMPLMNT   = alu_pkg::DEFUALT,
    parameter int unsigned DATA_WIDTH         = FEATURES.WIDTH,
    parameter int unsigned ADDR_WIDTH         = FEATURES.WIDTH,
    parameter int unsigned NUM_OPERANDS       = 2
  )(
    input  logic                               clk_i,
    input  logic                               rst_n_i,
    input  logic                               test_en_i,
    input  logic [ADDR_WIDTH-1:0]              boot_addr_i,
    // INSTRUCTION MEMORY INTF
    output logic                               inst_req_o,
    input  logic                               inst_grnt_i,
    output logic [ADDR-1:0]                    inst_addr_o,
    output logic                               inst_valid_o,
    input  logic [DATA_WIDTH-1:0]              inst_data_i,    
    // DATA MEMORY INTF
    output logic                               data_mem_req_o,
    input  logic                               data_mem_grnt_i,
    output logic [ADDR-1:0]                    data_mem_addr,
    output logic                               data_mem_valid_o,
    input  logic [DATA_WIDTH-1:0]              data_mem_rdata_i,
    output logic                               data_mem_ren_o,
    output logic [DATA_WIDTH-1:0]              data_mem_wdata,
    output logic                               data_mem_wen_o,
    output logic [((DATA_WIDTH)/BEATSIZE)-1:0] data_mem_beat_o,    
    // INTERUPT INTF
    // DEBUGING
  
    // VERIFICATION IF

    );
    
    // WB
    // ALU
    // LSU
    // MULTIPLY
    // ID
    // CSR


    core_decoder u_decoder (
      .clk_i(clk_i),
      .rst_n_i(rst_n_i),
      .rs0_re_i(rs0_re_i),
      .rs0_addr_i(rs0_addr_i),
      .rs0_data_i(rs0_data_i),
      .rs1_re_i(rs1_re_i),
      .rs1_addr_i(rs1_addr_i),
      .rs1_data_i(rs1_data_i),
      .rd_we_i(rd_we_i),
      .rd_addr_i(rd_addr_i),
      .rd_data_i(rd_data_i)
    );
      
      
    /*
        REGFILE: 
    */
    core_regfile u_core_regfile (
      .clk_i(clk_i),
      .rst_n_i(rst_n_i),
      .rs0_re_i(rs0_re_i),
      .rs0_addr_i(rs0_addr_i),
      .rs0_data_i(rs0_data_i),
      .rs1_re_i(rs1_re_i),
      .rs1_addr_i(rs1_addr_i),
      .rs1_data_i(rs1_data_i),
      .rd_we_i(rd_we_i),
      .rd_addr_i(rd_addr_i),
      .rd_data_i(rd_data_i)
    );
      

    alu #( ) u_alu (
      .operands_i(operands_i),
      .alu_op_i(alu_op_i),
      .result_o(result_o),
      .adder_o(adder_o),
      .comp_o(comp_o)
    );
      
  endmodule :core 