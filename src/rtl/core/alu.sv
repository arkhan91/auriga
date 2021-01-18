
//LISENCE
  import alu::*;
  module alu #(
    parameter alu::alu_feature_t FEATURES     = core_pkg::RV32D,
    parameter alu::implementation_t IMPLMNT   = alu_pkg::DEFUALT,
    parameter int unsigned DATA_WIDTH         = FEATURES.WIDTH,
    parameter int unsigned NUM_OPERANDS       = 2
  )(
  
    input  logic [NUM_OPERANDS-1:0] [DATA_WIDTH-1:0]  operands_i,
    input  core::alu_operation_t                      alu_op_i,
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

    localparam int unsigned SHAMT_WIDTH = FEATURES.SHAMT_WIDTH;
    logic [SHAMT_WIDTH-1:0] shamt;
    logic [DATA_WIDTH-1:0] shift_result;
    logic [DATA_WIDTH-1:0] comparator_result;
    logic [DATA_WIDTH:0]   arthmatic_result;
/*
    // ADDITION OPERATION 
    //assign in2_inv = (alu_op_i.sub) ^ (operands_i[1]);
    //assign adder_o = (operands_i[0] + in2_inv) + alu_op_i.sub;
    always_comb begin
      unique case (alu_op_i.arthmatic)
        ADD :  arthmatic_result = operands_i[0] + operands_i[1];
        SUB :  arthmatic_result = operands_i[0] - operands_i[1];
      endcase
    end

    // BITWISE OPERATION
    always_comb begin
      unique case (alu_op_i.logical)
        AND:  alu_logic = operands_i[0] & operands_i[1];
        OR :  alu_logic = operands_i[0] | operands_i[1];
        XOR:  alu_logic = operands_i[0] ^ operands_i[1];        
      endcase
    end
    // LOGICIAL OPERATION
    assign shamt =  operands_i [0] [SHAMT_WIDTH-1:0];
    always_comb begin
      case (alu_op_i.condition)
        SLL  :  shift_result  = operands_i[1] << shamt;
        SRR  :  shift_result  = $reverse(operands_i[1]) << shamt; 
        SLT  :  shift_result  = $reverse(operands_i[1]) << shamt; 
        SLTU :  shift_result  = $reverse(operands_i[1]) << shamt; 
        SRL  :  shift_result  = $reverse(operands_i[1]) << shamt; 
        SRA  :  shift_result  = $reverse(operands_i[1]) << shamt; 

      endcase
    end
    // COMPARATOR OPERATION
    always_comb begin
      case (alu_op_i.compare)
        LT    :  comparator_result  = operands_i[0] < operands_i[1];
        LTE   :  comparator_result  = operands_i[0] <= operands_i[1]; 
        GT    :  comparator_result  = operands_i[0] > operands_i[1]; 
        GTE   :  comparator_result  = operands_i[0] >= operands_i[1];
      endcase
    end
    always_comb begin
      unique case (alu_inst_i)
        ADDITION : result = arthmatic_result[DATA_WIDTH-1:0];
        CONDTION : result = shift_result;
        LOGICAL  : result = alu_logic;
        COMPARE  : result = comparator_result;
      endcase
    end

   
    */

    always_comb begin
      unique case (alu_op_i)
        ADD :  result   = operands_i[0] + operands_i[1];
        SUB :  result   = operands_i[0] - operands_i[1];
        AND:  result    = operands_i[0] & operands_i[1];
        OR :  result    = operands_i[0] | operands_i[1];
        XOR:  result    = operands_i[0] ^ operands_i[1];  
        SLL  :  result  = operands_i[1] << shamt;
        SRR  :  result  = $reverse(operands_i[1]) << shamt; 
        SLT  :  result  = $reverse(operands_i[1]) << shamt; 
        SLTU :  result  = $reverse(operands_i[1]) << shamt; 
        SRL  :  result  = $reverse(operands_i[1]) << shamt; 
        SRA  :  result  = $reverse(operands_i[1]) << shamt; 
      endcase
    end

    assign result_o = result;
    assign comp_o   = 1'b1;
  endmodule :alu 