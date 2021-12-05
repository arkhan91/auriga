
/***************************************************************************************
File name     : branch_sel.sv
Project       : Auriga
Language      : SystemVerilog
Description   : Branch selector
***************************************************************************************
*/
module core_writeback(
    input logic                                       clk_i,
    input logic                                       arst_ni,

    input logic                                       stall_i,

    input  logic [32-1:0]                     alu_result_i,
    input logic     [4:0]                             rd_addr_i,

    output logic     [4:0]                            rd_addr_o,
    output logic [32-1:0]                              data_o
);

logic [31:0]                     alu_result_q,alu_result_d;
logic [31:0]                     loaded_data_q,loaded_data_d;
logic     [4:0]                            rd_addr_d,rd_addr_q;


always_comb begin
    rd_addr_d = rd_addr_i;
    loaded_data_d=  '0;
    alu_result_d = alu_result_i;
end
always_ff @(posedge clk_i or negedge arst_ni) begin
    if (!arst_ni) begin
        loaded_data_q <= '0;
        alu_result_q   <= '0;
        rd_addr_q  <= '0;
    end else begin
        loaded_data_q <= (stall_i) ? loaded_data_q: loaded_data_d;
        rd_addr_q   <= (stall_i) ? rd_addr_q  : rd_addr_d;
        alu_result_q  <= (stall_i) ? alu_result_q : alu_result_d;

    end      
end

assign rd_addr_o = rd_addr_q;
assign data_o    = alu_result_q;


    
endmodule