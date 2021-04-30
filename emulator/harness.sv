import core_pkg::*;

//import "DPI-C" function read_elf(input string filename);
//import "DPI-C" function byte get_section(output longint address, output longint len)mailbox mbx
import "DPI-C" context function byte read_section (input longint address,inout byte buffer[]);
module auriga_harness 
  (
    input logic clk_i,     
    input logic arst_ni
    
    
  );
    
  //    // Load an ELF binary.
  //task load_binary;
  //  input string binary;
  //  longint section_addr, section_len;
  //  byte buffer[];
  //  $display("Loading ELF binary '%s'", binary);
  //  void'(read_elf(binary));
  //  while (get_section(section_addr, section_len)) begin
  //    automatic int num_words = (section_len+AXI_BYTES-1)/AXI_BYTES;
  //    $display("Loading section %x", section_addr);
  //    buffer = new [num_words*AXI_BYTES];
  //    void'(read_section(section_addr, buffer));
  //    for (int i = 0; i < num_words; i++) begin
  //      automatic logic [AXI_BYTES-1:0][7:0] word = '0;
  //      for (int j = 0; j < AXI_BYTES; j++)
  //        word[j] = buffer[i*AXI_BYTES+j];
  //      memory[section_addr/AXI_BYTES+i] = word;
  //    end
  //  end
  //  $display("ELF binary loaded");
  //endtask
//
  //// Dump the memory to disk.
  //task dump_memory;
  //  automatic string filename = "memory_dump.txt";
  //  automatic int fd = $fopen(filename, "w");
  //  $display("[MEMORY] Dumping memory to: %s", filename);
  //  foreach (memory[word]) begin
  //    automatic bit [31:0] addr = word * AXI_BYTES;
  //    for (int i = 0; i < AXI_BYTES/4; i++)
  //      $fwrite(fd, "%08x  %08x\n", addr + i*4, memory[word][32*i+:32]);
  //  end
  //  $fclose(fd);
  //endtask
  //
  //
  `ifndef VERILATOR

  logic clk_i,     
        arst_ni,;
  
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
    arst_ni <= 0;
    repeat(n) @(posedge clk_i);
    arst_ni <= 1;
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
    .inst_valid_i(inst_valid_i),   
    
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