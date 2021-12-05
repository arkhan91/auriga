
// LISCENCE
module core_execution#(
    parameter int unsigned DATA_WIDTH         = 32,
    parameter int unsigned SHAMT_WIDTH        = 5
  )(
  
    input logic                                       clk_i,
    input logic                                       arst_ni,

    input logic                                       stall_i,

    input  logic [DATA_WIDTH-1:0]                     operands_a_i,
    input  logic [DATA_WIDTH-1:0]                     operands_b_i,
    input  logic [DATA_WIDTH-1:0]                     program_cnt_i,
    input logic [4:0] rd_addr_i,


    input  logic [4:0]                                alu_op_i,
    input  logic                                      invert_i,
    output logic [DATA_WIDTH-1:0]                     result_o,
    output logic [DATA_WIDTH:0]                       adder_o,
    output logic                                      comp_o,
    output logic [4:0] rd_addr_o

    );

  
    logic [DATA_WIDTH-1:0] result_d; 
    logic [DATA_WIDTH-1:0] result_q; 
    logic [DATA_WIDTH:0] adder_d,adder_q;
    logic comp_d,comp_q;
    logic [4:0] rd_addr_d,rd_addr_q;

alu #() u_alu(
    .operands_a_i(operands_a_i),
    .operands_b_i(operands_b_i),
    .alu_op_i(alu_op_i),
    .invert_i(invert_i),
    .result_o(result_d),
    .adder_o(adder_d),
    .comp_o(comp_d)
    );
    assign rd_addr_d = rd_addr_i;
    always_ff @(posedge clk_i or negedge arst_ni) begin
      if (!arst_ni) begin
          result_q <= '0;
          comp_q   <= '0;
          adder_q  <= '0;
          rd_addr_q<='0;
      end else begin
          result_q <= (stall_i) ? result_q: result_d;
          comp_q   <= (stall_i) ? comp_q  : comp_d;
          adder_q  <= (stall_i) ? adder_q : adder_d;
          rd_addr_q  <= (stall_i) ? rd_addr_q : rd_addr_d;

      end      
  end


  assign result_o  = result_q;
  assign comp_o    = comp_q;
  assign adder_o   = adder_q;
  assign rd_addr_o   = rd_addr_q;



endmodule : core_execution