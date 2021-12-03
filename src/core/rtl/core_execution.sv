
// LISCENCE
module core_execution#(
    parameter int unsigned DATA_WIDTH         = 32,
    parameter int unsigned SHAMT_WIDTH        = 5
  )(
  
    input  logic [DATA_WIDTH-1:0]                     operands_a_i,
    input  logic [DATA_WIDTH-1:0]                     operands_b_i,

    input  logic [4:0]                                alu_op_i,
    input  logic                                      invert_i,

    output logic [DATA_WIDTH-1:0]                     result_o,
    output logic [DATA_WIDTH:0]                       adder_o,
    output logic                                      comp_o
    );

    

alu #() u_alu(
    .operands_a_i(alu_operand_a),
    .operands_b_i(alu_operand_b),
    .alu_op_i(alu_op_i),
    .result_o(result_o),
    .adder_o(adder_o),
    .comp_o(comp_o)
    );

endmodule : core_execution