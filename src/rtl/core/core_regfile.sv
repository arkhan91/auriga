//LISENCE
  module core_regfile 
  (
    input logic clk_i,
    input logic rst_n_i,
    
    input logic                         rs0_re_i,
    input logic [4:0] rs0_addr_i,
    output logic [31:0] rs0_data_i,
    
    input logic                         rs1_re_i,
    input logic [4:0] rs1_addr_i,
    output logic [31:0] rs1_data_i,
    
    
    input logic                         rd_we_i,
    input logic [4:0] rd_addr_i,
    input logic [31:0] rd_data_i
    );
    
    localparam int unsigned OPRAND_ADDR_WIDTH = 5;
    localparam int unsigned OPRAND_DATA_WIDTH = 32;
    
    logic [OPRAND_DATA_WIDTH-1:0] regfile [2**OPRAND_ADDR_WIDTH];
    
    always_ff @(posedge clk_i) begin
      if (rs0_re_i)
        rs0_data_i <= regfile[rs0_addr_i];
    end
    
    always_ff @(posedge clk_i) begin
      if (rs1_re_i)
        rs1_data_i <= regfile[rs1_addr_i];
    end
    
    always_ff @(posedge clk_i) begin
      if (rd_we_i)
        regfile[rd_addr_i] <= rd_data_i;
    end
    
    
  endmodule :core_regfile 