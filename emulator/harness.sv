module auriga_harness 
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



  `ifndef VERILATOR

  logic clk_i,     
        rst_n_i,;
  
  logic clk;
  

  parameter real  CLK1G_PERIOD = 1.0ns;   // 1.0Hz

    
  /* Create common 1GHz clock for Core */ 
  initial begin: clocking_block
    clk = 0; 
    forever #(CLK1G_PERIOD/2) clk = ~clk;
  end: clocking_block
  
  assign  clk_i = clk;
  
  // Selective resets for all clock domains
  task assert_rst(int unsigned n = 1);
    rst_n_i <= 0;
    repeat(n) @(posedge clk_i);
    rst_n_i <= 1;
  endtask
    


  task wait_1G_cycles(int unsigned n);
    repeat(n) @(posedge clk);
  endtask
         
`endif

  core_regfile 
  u_core_regfile (
    .clk_i(clk_i),
    .rst_n_i(rst_n_i),
    .rs0_re_i(rs0_re_i),
    .rs0_addr_i(rs0_addr_i),
    .rs0_data_i(rs0_data_i),
    .rs1_re_i(rs1_re_i),
    .rs1_addr_i(rs1_addr_i),
    .rs1_data_i(rs1_data_i),
    .rd_we_i(rd_we_i),
    .rd_addr_i(rd_addr_i),
    .rd_data_i(rd_data_i)
    );
initial begin
  
end

endmodule:auriga_harness