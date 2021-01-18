module inst_fetch #() (  
   input  logic                               clk_i,
   input  logic                               arst_ni,
   // INSTRUCTION MEMORY
   output logic                               inst_req_o,
   input  logic                               inst_grnt_i,
   output logic [ADDR-1:0]                    inst_addr_o,
   output logic                               inst_valid_o,
   input  logic [DATA_WIDTH-1:0]              inst_data_i,
   // INSTRUCTION DECODER
   output core_pkg::instruction               instruction_o,
   // Program Counter


 ); 

 // Instruction Memory
 // Instruction memory interface to interconnect
 instruction_buffer();
 
 // program_counter
 Controller();
 // Controller
 Controller();


endmodule:inst_fetch