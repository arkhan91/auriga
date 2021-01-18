
// LICENSE
module sync_ff  #(
    parameter int unsigned LEVELS = 4
)(
    input  logic clk_i,
    input  logic arst_ni,
    output logic stream_i,
    output logic stream_o
);

logic [LEVELS-1:0] sync_q,sync_d;

always_comb begin
    sync_d = {sync_q[LEVELS-2:1],stream_i};
end

always_ff @(posedge ck or negedge arst_ni) begin
    if (!arst_ni) begin
        sync_q <= '0;
    end else begin
        sync_q <= sync_d;
    end     
end
assign stream_o = sync_q[LEVELS-1];
endmodule 