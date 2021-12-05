

/***************************************************************************************
File name     : load_store.sv
Project       : Auriga
Language      : SystemVerilog
Description   : load store
***************************************************************************************
*/
// Calculate the address 

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