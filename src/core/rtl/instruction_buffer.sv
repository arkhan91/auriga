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