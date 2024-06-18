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
/***************************************************************************************
File name     : branch_sel.sv
Project       : Auriga
Language      : SystemVerilog
Description   : Branch selector
***************************************************************************************/

import core_pkg::*;
module core_fetch(
    input logic                                clk_i,
    input logic                                arst_ni,
    
    output logic                               inst_req_o,
    input  logic                               inst_grnt_i,
    output logic [31:0]                        inst_addr_o,
    input  logic [31:0]                        inst_data_i,   
    input  logic                               inst_valid_i,
    
    input  logic                               flush_i,
    input  logic                               stall_i,
    input  logic                               exception_i,
    input  logic                               branch_i,
    
    input  logic [31:0]                        pc_next_i,
    input  logic [31:0]                        branch_pc_i,

    output logic [31:0]                        instruction_o,  
    output logic                               instruction_valid_o,  
    output logic [31:0]                        program_cnt_o  

);
    
logic [31:0] program_counter_q;
logic [31:0] program_counter_d;

logic [31:0] instruction_d;
logic [31:0] instruction_q;
logic instr_req_d;
logic instr_req_q;
logic instr_valid_d;
logic instr_valid_q;


always_comb 
begin
    program_counter_d = program_counter_q + 'd4;
    if(branch_i && !stall_i) begin
        program_counter_d = branch_pc_i;
    end 

    instr_req_d = 1'b1;
    instr_valid_d = inst_valid_i;
    instruction_d = (inst_valid_i) ? inst_data_i : instruction_q;
end

always_ff @(posedge clk_i or negedge arst_ni) begin
    if (!arst_ni) begin
        program_counter_q <= '0;
        instruction_q     <= '0;
        instr_req_q       <= '0;
        instr_valid_q     <= '0;
    end else begin
        program_counter_q <= program_counter_d;
        instruction_q     <= instruction_d;
        instr_req_q       <= instr_req_d;
        instr_valid_q     <= instr_valid_d;
    end     
end

assign inst_addr_o   = program_counter_q;
assign instruction_o = instruction_q;
assign inst_req_o    = instr_req_q;
assign instruction_valid_o = instr_valid_q;
assign program_cnt_o = program_counter_q;

endmodule : core_fetch
