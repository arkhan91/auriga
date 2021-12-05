import core_pkg::*;

//import "DPI-C" function read_elf(input string filename);
//import "DPI-C" function byte get_section(output longint address, output longint len)mailbox mbx
import "DPI-C" context function byte read_section (input longint address,inout byte buffer[]);
module auriga_harness 
  (
    input logic clk_i,     
    input logic arst_ni
    
    
  );
    

 `ifndef VERILATOR

  logic clk_i,     
        arst_ni;
  
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
    arst_ni = 0;
    repeat(n) @(posedge clk_i);
    arst_ni = 1;
  endtask
    


  task wait_1G_cycles(int unsigned n);
    repeat(n) @(posedge clk);
  endtask
         
`endif


core #(
) u_core(
    .clk_i(clk_i),
    .arst_ni(arst_ni),
    
    .inst_req_o(inst_req_o),
    .inst_grnt_i(inst_grnt_i),
    .inst_addr_o(inst_addr_o),
    .inst_data_i(32'b111111001110_00001_000_01111_0010011),
    .inst_valid_i(1'b1),   
    
    .data_mem_req_o(data_mem_req),
    .data_mem_grnt_i(data_mem_grnt),
    .data_mem_addr_o(data_mem_ad),
    .data_mem_rdata_i(data_mem_rdata),
    .data_mem_wdata_o(data_mem_valid),
    .data_mem_valid_o(data_mem_ren),
    .data_mem_ren_o(data_mem_wda),
    .data_mem_wen_o(data_mem_wen)
    );
    
initial begin
 // load_binary();
end

endmodule:auriga_harness