
//LISENCE
  import core_pkg::*;
  module core #(
  )(
    input  logic                               clk_i,
    input  logic                               rst_n_i,
    
    output logic                               inst_req_o,
    input  logic                               inst_grnt_i,
    output logic [31:0]                        inst_addr_o,
    input  logic [31:0]                        inst_data_i,   
    input  logic                               inst_valid_i,
    
    output logic                               data_mem_req_o,
    input  logic                               data_mem_grnt_i,
    output logic [31:0]                        data_mem_addr_o,
    input  logic [31:0]                        data_mem_rdata_i,
    output logic [31:0]                        data_mem_wdata_o,
    output logic                               data_mem_valid_o,
    output logic                               data_mem_ren_o,
    output logic                               data_mem_wen_o
    );
    core_pkg::core_ctrl_t core_ctrl;
    
     logic  [31:0]  alu_operand_a;
     logic  [31:0]  alu_operand_b;
     logic [31:0]      instruction;
     logic [31:0]                  alu_result;
     logic [32:0]                  adder;
     logic [31:0]                  rs0_data;
     logic [31:0]                  rs1_data;
     logic                         rd_en;

    core_regfile u_core_regfile (
      .clk_i(clk_i),
      .rst_n_i(rst_n_i),
      .rs0_addr_i(core_ctrl.addr.rs1_addr),
      .rs0_data_i(rs0_data),
      .rs1_addr_i(core_ctrl.addr.rs2_addr),
      .rs1_data_i(rs1_data),
      .rd_we_i(rd_en),
      .rd_addr_i(core_ctrl.addr.rd_addr),
      .rd_data_i(alu_result)
      );
      
      assign alu_operand_a = (core_ctrl.op_mux_sel_0==REG_OPERAND) ? rs0_data : core_ctrl.sign_extended;
      assign alu_operand_b =rs1_data ;
      assign rd_en = core_ctrl.result_write;


    core_decoder u_core_decoder(
      .clk_i(clk_i),
      .rst_n_i(rst_n_i),
      .instruction_i(instruction),
      .instruction_valid_i(1'b1),
      .id_pc_i(),
      .stall_i(),
      .sign_extended_o(),
      .core_ctrl(core_ctrl)
    );
      
    core_execution #( ) u_core_execution (
      .operands_a_i(alu_operand_a),
      .operands_b_i(alu_operand_b),
      .alu_op_i(core_ctrl.alu_op),
      .shamt_i('d2),
      .result_o(alu_result),
      .adder_o(adder),
      .comp_o(comp_o)
    );


    core_fetch u_core_fetch(
      .clk_i(clk_i),
      .rst_n_i(rst_n_i),
      .inst_req_o(inst_req_o),
      .inst_grnt_i(inst_grnt_i),
      .inst_addr_o(inst_addr_o),
      .inst_data_i(inst_data_i),   
      .inst_valid_i(inst_valid_i),
      .flush_i(),
      .stall_i(1'b0),
      .exception_i(1'b0),
      .branch_i(1'b0),
      .pc_next_i(pc_next),
      .branch_pc_i('d0),
      .instruction_o(instruction),  
      .instruction_valid_o(instruction_valid),  
      .pc_o(pc)
  
  );

      
  endmodule :core 