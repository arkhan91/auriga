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

module inst_fetch #() (  
   input  logic                               clk_i,
   input  logic                               arst_ni,
   // INSTRUCTION MEMORY
   output logic                               inst_req_o,
   input  logic                               inst_grnt_i,
   output logic [ADDR-1:0]                    inst_addr_o,
   output logic                               inst_valid_o,
   input  logic [DATA_WIDTH-1:0]              inst_data_i,
   // INSTRUCTION DECODER
   output core_pkg::instruction               instruction_o,
   // Program Counter


 ); 

 // Instruction Memory
 // Instruction memory interface to interconnect
 instruction_buffer();
 
 // program_counter
 Controller();
 // Controller
 Controller();


endmodule:inst_fetch