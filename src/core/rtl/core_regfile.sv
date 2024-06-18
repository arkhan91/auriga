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

  module core_regfile 
  (
    input  logic        clk_i,
    input  logic        arst_ni,
    input  logic        rdes_we_i,
    input  logic [4:0]  rsrc0_addr_i,
    input  logic [4:0]  rsrc1_addr_i,
    input  logic [4:0]  rdes_addr_i,
    input  logic [31:0] rdes_data_i,
    output logic [31:0] rsrc0_data_o,
    output logic [31:0] rsrc1_data_o
  );
     
    localparam int unsigned OPRAND_ADDR_WIDTH = 5;
    localparam int unsigned OPRAND_DATA_WIDTH = 32;
    logic [OPRAND_DATA_WIDTH-1:0] regfile [2**OPRAND_ADDR_WIDTH];
    
    core_pkg::register_file_t rs0_addr;
    core_pkg::register_file_t rs1_addr;
    core_pkg::register_file_t rd_addr;

    assign rs0_addr = core_pkg::register_file_t'(rsrc0_addr_i);
    assign rs1_addr = core_pkg::register_file_t'(rsrc1_addr_i);
    assign rd_addr  = core_pkg::register_file_t'(rdes_addr_i);

    always_ff @(posedge clk_i) begin
        rsrc0_data_o <= regfile[rsrc0_addr_i];
        rsrc1_data_o <= regfile[rsrc1_addr_i];
    end
    
    
    always_ff @(posedge clk_i) begin
      if (rdes_we_i && rdes_addr_i!='d0)
        regfile[rdes_addr_i] <= rdes_data_i;
    end
    
    
  endmodule :core_regfile 