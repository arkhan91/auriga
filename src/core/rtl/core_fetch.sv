
// LISCENCE
import core_pkg::*;
module core_fetch(
    input logic                                clk_i,
    input logic                                arst_ni,
    
    output logic                               inst_req_o,
    input  logic                               inst_grnt_i,
    output logic [31:0]                        inst_addr_o,
    input  logic [31:0]                        inst_data_i,   
    input  logic                               inst_valid_i,
    
    input  logic                               flush_i,
    input  logic                               stall_i,
    input  logic                               exception_i,
    input  logic                               branch_i,
    
    input  logic [31:0]                        pc_next_i,
    input  logic [31:0]                        branch_pc_i,

    output logic [31:0]                        instruction_o,  
    output logic                               instruction_valid_o,  
    output logic [31:0]                        program_cnt_o  

);
    
logic [31:0] program_counter_q;
logic [31:0] program_counter_d;

logic [31:0] instruction_d;
logic [31:0] instruction_q;
logic instr_req_d;
logic instr_req_q;
logic instr_valid_d;
logic instr_valid_q;

assign program_counter_d = (branch_i && !stall_i)? branch_pc_i : (!stall_i)? program_counter_q + 'd4 : program_counter_q;

always_ff @(posedge clk_i or negedge arst_ni) begin
    if (!arst_ni) begin
        program_counter_q <= '0;
        instruction_q     <= '0;
        instr_req_q       <= '0;
        instr_valid_q     <= '0;
    end else begin
        program_counter_q <= program_counter_d;
        instruction_q     <= instruction_d;
        instr_req_q       <= 1'b1;
        instr_valid_q     <= inst_valid_i;
    end     
end


always_comb begin
    instruction_d = (inst_valid_i) ? inst_data_i : instruction_q;
end

assign inst_addr_o   = program_counter_q;
assign instruction_o = instruction_q;
assign inst_req_o    = instr_req_q;
assign instruction_valid_o = instr_valid_q;
assign program_cnt_o = program_counter_q;

/*
controller();
instruction_fetch();
predecode();
*/
endmodule : core_fetch