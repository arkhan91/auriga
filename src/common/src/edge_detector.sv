
// LICENSE
module edge_detector  #(
    parameter int unsigned LEVELS = 2
)(
    input  logic clk_i,
    input  logic arst_ni,
    input  logic data_i,
    output logic data_o,

    output logic falling_edge_o,
    output logic rising_edge_o
);
logic data_stream;
logic data_stream_q;
logic data_stream_d;

sync_ff #(
    .LEVELS(LEVELS)
) (
    .clk_i(clk_i),
    .arst_ni(arst_ni),
    .stream_i(data_i),
    .stream_o(data_stream_d)
);

assign falling_edge_o = (~data_i) & data_stream_q;
assign falling_edge_o = data_i & ~data_stream_q;



always_ff @(posedge clk_i or negedge arst_ni) begin
    if (!arst_ni) begin
        data_stream_q <= '0;
    end else begin
        data_stream_q <= data_stream_d;
    end     
end
assign data_o = data_stream_q;
endmodule 