
//LISENCE
  import core_pkg::*;
  module alu #(
    parameter int unsigned DATA_WIDTH         = 32,
    parameter int unsigned SHAMT_WIDTH        = 5
  )(
  
    input  logic [DATA_WIDTH-1:0]                     operands_a_i,
    input  logic [DATA_WIDTH-1:0]                     operands_b_i,

    input  logic [4:0]                                alu_op_i,
    input  logic [SHAMT_WIDTH-1:0]                    shamt_i,
    input  logic                                      invert_i,

    output logic [DATA_WIDTH-1:0]                     result_o,
    output logic [DATA_WIDTH:0]                       adder_o,
    output logic                                      comp_o
    );
    
    // IMEDIATE OPERATION
    // ROTATE OPERATION
    // 
    logic adder_sel;
    logic shift_sel;
    logic logic_sel;
    logic [DATA_WIDTH-1:0]                     result;

    logic [DATA_WIDTH-1:0] in2_inv;

    logic [DATA_WIDTH-1:0] alu_logic;
    logic [DATA_WIDTH-1:0] shift_result;
    logic [DATA_WIDTH-1:0] comparator_result;
    logic [DATA_WIDTH:0]   arthmatic_result;
    
    always_comb begin
      unique case (alu_op_i)
        ADD :  result   = (invert_i) ? operands_a_i - operands_b_i:operands_a_i + operands_b_i;
        AND:  result    = operands_a_i & operands_b_i;
        OR :  result    = operands_a_i | operands_b_i;
        XOR:  result    = operands_a_i ^ operands_b_i;  
        SLL  :  result  = operands_b_i << operands_a_i;//WIP
        SLT  :  result  = operands_b_i << operands_a_i;//WIP 
        SLTU :  result  = operands_b_i << $unsigned(operands_a_i); 
        SRL  :  result  = (invert_i) ? operands_b_i >> operands_a_i:operands_b_i >> operands_a_i; 
      endcase
    end

    assign result_o = result;
    assign comp_o   = 1'b1;
  endmodule :alu 