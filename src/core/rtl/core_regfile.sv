//LISENCE
  module core_regfile 
  (
    input logic clk_i,
    input logic arst_ni,
    
    input logic [4:0] rs0_addr_i,
    output logic [31:0] rs0_data_o,
    
    input logic [4:0] rs1_addr_i,
    output logic [31:0] rs1_data_o,
    
    
    input logic                         rd_we_i,
    input logic [4:0] rd_addr_i,
    input logic [31:0] rd_data_i
    );
     
    localparam int unsigned OPRAND_ADDR_WIDTH = 5;
    localparam int unsigned OPRAND_DATA_WIDTH = 32;
    
    logic [OPRAND_DATA_WIDTH-1:0] regfile [2**OPRAND_ADDR_WIDTH];
    core_pkg::register_file_t rs0_addr;
    core_pkg::register_file_t rs1_addr;
    core_pkg::register_file_t rd_addr;

    assign rs0_addr = core_pkg::register_file_t'(rs0_addr_i);
    assign rs1_addr = core_pkg::register_file_t'(rs1_addr_i);
    assign rd_addr  = core_pkg::register_file_t'(rd_addr_i);

    always_ff @(posedge clk_i) begin
        rs0_data_o <= regfile[rs0_addr_i];
        rs1_data_o <= regfile[rs1_addr_i];
    end
    
    
    always_ff @(posedge clk_i) begin
      if (rd_we_i && rd_addr_i!='d0)
        regfile[rd_addr_i] <= rd_data_i;
    end
    
    
  endmodule :core_regfile 