
//LISENCE
// CACHE
  module instruction_buffer #(
    parameter core::alu_feature_t FEATURES     = core_pkg::RV32D,
    parameter alu::implementation_t IMPLMNT   = alu_pkg::DEFUALT,
    parameter int unsigned DATA_WIDTH         = FEATURES.WIDTH,
    parameter int unsigned NUM_OPERANDS       = 2
  )(
     // INSTRUCTION MEMORY 
    output logic                               inst_req_o,
    input  logic                               inst_grnt_i,
    input logic [ADDR-1:0]                     inst_waddr_i,
    output logic                               inst_valid_o,
    input  logic [DATA_WIDTH-1:0]              inst_data_i,

    output  logic [DATA_WIDTH-1:0]             inst_data_o
    input logic [ADDR-1:0]                     inst_raddr_i

    );
    
    // Implementation Style
    // dual port memory
    module dp_memory  #(
      parameter int unsigned DATA_WIDTH = 32,
      parameter int unsigned DEPTH      = 1024
  
  )(
      .clk_i,
  
      .we_i(inst_req_o),
      .wdata_i(inst_data_i),
      .waddr_i(inst_waddr_i),
  
      .re_i(),
      .raddr_i(inst_raddr_i),
      .rdata_o(inst_data_o)
  );
  endmodule :instruction_buffer 