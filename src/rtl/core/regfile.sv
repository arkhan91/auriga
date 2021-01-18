module regfile #(
    parameter core::alu_feature_t FEATURES     = core_pkg::RV32D,
    parameter core::implementation_t IMPLMNT   = core_pkg::DEFUALT,
    parameter int unsigned DATA_WIDTH         = FEATURES.WIDTH,
    parameter int unsigned ADDR_WIDTH         = FEATURES.REG_ADDR,

    parameter int unsigned NUM_OPERANDS       = 3
)(
    input  logic                                      clk_i,
    output logic                                      arst_ni,
    // READ PORTS
    output logic [1:0] [DATA_WIDTH-1:0]  roperands_o,
    input  logic [1:0] [ADDR_WIDTH-1:0]  raddr_i,
    input  logic [1:0]                   ren_i,
    

    // WRITE PORTS
    input  logic  [DATA_WIDTH-1:0]  woperands_i,
    input  logic  [ADDR_WIDTH-1:0]  waddr_i,
    input  logic                    wen_i

    
);

logic [DATA_WIDTH-1:0] regfile_q [NUM_REG];
logic [DATA_WIDTH-1:0] regfile_d [NUM_REG];

always_ff @(posedge ck or negedge arst_ni) begin
    if (!arst_ni) begin
        regfile_q[NUM_REG-1:1] <= '0;
    end else begin
    
        regfile_q[NUM_REG-1:1] <= regfile_d[NUM_REG-1:1] ;
    end     
end
assign regfile_q[0] ='0;
always_comb begin

    regfile_d [waddr_i]       =  (wen_i) ?   woperands_i : regfile_q;
    roperands_o[raddr_i[0]]   =  (ren_i[0]) ? regfile_q [waddr_operand_i];
    roperands_o[raddr_i[1]]   =  (ren_i[1]) ? regfile_q [waddr_operand_i];

end
endmodule