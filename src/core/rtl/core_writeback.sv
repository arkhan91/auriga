
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
***************************************************************************************
*/
module core_writeback(
    input logic                                       clk_i,
    input logic                                       arst_ni,

    input logic                                       stall_i,

    input  logic [32-1:0]                     alu_result_i,
    input logic     [4:0]                             rd_addr_i,

    output logic     [4:0]                            rd_addr_o,
    output logic [32-1:0]                              data_o
);

logic [31:0]                     alu_result_q,alu_result_d;
logic [31:0]                     loaded_data_q,loaded_data_d;
logic     [4:0]                            rd_addr_d,rd_addr_q;


always_comb begin
    rd_addr_d = rd_addr_i;
    loaded_data_d=  '0;
    alu_result_d = alu_result_i;
end
always_ff @(posedge clk_i or negedge arst_ni) begin
    if (!arst_ni) begin
        loaded_data_q <= '0;
        alu_result_q   <= '0;
        rd_addr_q  <= '0;
    end else begin
        loaded_data_q <= (stall_i) ? loaded_data_q: loaded_data_d;
        rd_addr_q   <= (stall_i) ? rd_addr_q  : rd_addr_d;
        alu_result_q  <= (stall_i) ? alu_result_q : alu_result_d;

    end      
end

assign rd_addr_o = rd_addr_q;
assign data_o    = alu_result_q;


    
endmodule