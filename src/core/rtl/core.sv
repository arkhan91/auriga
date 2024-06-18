/*
MIT License

Copyright (c) 2020 arkhan91

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/
/***************************************************************************************
File name     : branch_sel.sv
Project       : Auriga
Language      : SystemVerilog
Description   : Branch selector
***************************************************************************************/


//LISENCE
  import core_pkg::*;
  module core (
    input  logic                               clk_i,
    input  logic                               arst_ni,
    
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
    
     logic  [31:0]  alu_operand_a;
     logic  [31:0]  alu_operand_b;
     logic [31:0]      instruction;
     logic [31:0]                  alu_result;
     logic [32:0]                  adder;
     logic [31:0]                  rs0_data;
     logic [31:0]                  rs1_data;
     logic                         rd_en;
     logic                         stall;
     logic  [31:0] pc_dec;
     logic  [31:0] pc_fetch;

     logic [4:0]                   rd_addr;
     logic [31:0]                  rd_mem_data,rd_wb_data;
     logic [4:0]                   rd_exe_addr,rd_mem_addr,rd_wb_addr;

     core_pkg::core_ctrl_t core_ctrl;
      
      


      core_fetch u_core_fetch(
        .clk_i(clk_i),
        .arst_ni(arst_ni),
        .inst_req_o(inst_req_o),
        .inst_grnt_i(inst_grnt_i),
        .inst_addr_o(inst_addr_o),
        .inst_data_i(inst_data_i),   
        .inst_valid_i(inst_valid_i),
        .flush_i(),
        .stall_i(stall),
        .exception_i(1'b0),
        .branch_i(1'b0),
        .pc_next_i(pc_next),
        .branch_pc_i('d0),
        .instruction_o(instruction),  
        .instruction_valid_o(instruction_valid),  
        .program_cnt_o(pc_fetch)
    
    );  


 
    core_decoder u_core_decoder(
      .clk_i(clk_i),
      .arst_ni(arst_ni),
      .instruction_i(instruction),
      .program_cnt_i(pc_fetch),
      .alu_operand_a_o(alu_operand_a),
      .alu_operand_b_o(alu_operand_a),
      .program_cnt_o(pc_dec),
      .instruction_valid_i(1'b1),
      .stall_i(stall),
      .rd_addr_i(rd_wb_addr),
      .rd_data_i(rd_wb_data),
      .core_ctrl_o(core_ctrl)
    );
    
    core_execution u_core_execution (
      .clk_i(clk_i),
      .arst_ni(arst_ni),
      .operands_a_i(alu_operand_a),
      .operands_b_i(alu_operand_b),
      .alu_op_i(core_ctrl.alu_op),
      .invert_i(core_ctrl.invert),
      .rd_addr_i(core_ctrl.addr.rd_addr),
      .rd_addr_o(rd_exe_addr),
      .program_cnt_i(pc_dec),
      .stall_i(stall),
      .result_o(alu_result),
      .adder_o(adder),
      .comp_o(comp_o)
    );



    core_mem #( ) u_core_mem (
      .clk_i(clk_i),
      .arst_ni(arst_ni),
      .load_sel_i(1'b0),
      .store_sel_i(1'b1),
      .alu_result_i(alu_result),
      .rd_addr_i(rd_exe_addr),
      .rd_addr_o(rd_mem_addr),
      .data_o(rd_mem_data)
    );
          
    core_writeback u_core_writeback (
      .clk_i(clk_i),
      .arst_ni(arst_ni),
      .alu_result_i(rd_mem_data),
      .rd_addr_i(rd_mem_addr),
      .rd_addr_o(rd_wb_addr),
      .data_o(rd_wb_data)
    );


    



  
  endmodule :core 