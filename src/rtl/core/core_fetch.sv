
// LISCENCE
module core_fetch(
    input logic                                clk_i,
    input logic                                rst_n_i,
    
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
    output logic [31:0]                        pc_o  

);
    
logic [31:0] program_counter_q;
logic [31:0] program_counter_d;

assign program_counter_d = (branch_i && !stall_i)? branch_pc_i : (!stall_i)? program_counter_q + 'd4 : program_counter_q;
always_ff @(posedge clk_i or negedge rst_n_i) begin
    if (!rst_n_i) begin
        program_counter_q <= '0;
    end else begin
    
        program_counter_q <= program_counter_d;
    end     
end

assign inst_addr_o = program_counter_q;
assign instruction_o = inst_data_i;
assign inst_req_o = !rst_n_i;
assign instruction_valid_o = inst_valid_i;

/*
controller();
instruction_fetch();
predecode();
*/
endmodule : core_fetch