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
File name     : alu.sv
Project       : Auriga
Language      : SystemVerilog
Description   : alu
***************************************************************************************/

  import core_pkg::*;
  module alu #(
    parameter int unsigned DATA_WIDTH         = 32,
    parameter int unsigned SHAMT_WIDTH        = 5
  )(
  
    input  logic [DATA_WIDTH-1:0]                     operands_a_i,
    input  logic [DATA_WIDTH-1:0]                     operands_b_i,

    input  logic [4:0]                                alu_op_i,
    input  logic                                      invert_i,

    output logic [DATA_WIDTH-1:0]                     result_o,
    output logic [DATA_WIDTH:0]                       adder_o,
    output logic                                      comp_o,
    output logic                                      zero_o

    );
    
    // IMEDIATE OPERATION
    // ROTATE OPERATION
    // 
    logic adder_sel;
    logic shift_sel;
    logic logic_sel;
    logic [DATA_WIDTH-1:0]                     alu_result;

    logic [DATA_WIDTH-1:0] in2_inv;

    logic [DATA_WIDTH-1:0] alu_logic;
    logic [DATA_WIDTH-1:0] shift_result;
    logic [DATA_WIDTH-1:0] comparator_result;
    logic [DATA_WIDTH:0]   arthmatic_result;
    
    logic [DATA_WIDTH:0]  adder_d;

    assign adder_d   = operands_a_i + operands_b_i;

    always_comb begin
      unique case (alu_op_i)
          ADD_SUB: alu_result = operands_a_i + (invert_i ? - operands_b_i : operands_b_i);
          SLL:     alu_result = operands_a_i << operands_b_i[4:0];
          SLT:     alu_result = ($signed(operands_a_i) < $signed(operands_b_i)) ? 32'd1 : 32'd0;
          SLTU:    alu_result = (operands_a_i < operands_b_i) ? 32'd1 : 32'd0;
          XOR:     alu_result = operands_a_i ^ operands_b_i;
          SRL_SRA: alu_result = invert_i ? ($signed(operands_a_i) >>> operands_b_i[4:0]) : (operands_a_i >> operands_b_i[4:0]);
          OR:      alu_result = operands_a_i | operands_b_i;
          AND:     alu_result = operands_a_i & operands_b_i;
          default:           
          alu_result = 32'd0;      
      
      endcase

    end

    assign result_o = alu_result;
    assign comp_o   = 1'b1;
    assign adder_o  = adder_d;
    assign zero_o = (alu_result == 32'd0);

  endmodule :alu   