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


module load_store_unit();
    
logic [DATA_WIDTH-1:0]       result;

always_comb begin
    unique case (alu_op_i)
      lw  :  result    = offset+base_value;
      AND  :  result   = operands_a_i & operands_b_i;
      OR   :  result   = operands_a_i | operands_b_i;
      XOR  :  result   = operands_a_i ^ operands_b_i;  
      SLL  :  result   = $signed(operands_b_i) << $signed(operands_a_i);//WIP
      SLT  :  result   = ((operands_b_i) < $signed(operands_a_i))? 'd1:'d0;//WIP 
      SLTU :  result   = $unsigned(operands_b_i) < $unsigned(operands_a_i); 
      SRL_SRA  :  result   = (invert_i) ? operands_b_i >> operands_a_i : operands_b_i >> operands_a_i; 
    
    endcase
  end

endmodule