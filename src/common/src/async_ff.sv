
// LICENSE
module async_ff  #(
    parameter int unsigned LEVELS = 2,
    parameter int unsigned WIDTH  = 2,
    
)(
    input  logic                wclk_i,
    input  logic                warst_ni,
    input  logic [WIDTH-1:0]    stream_i,
    input  logic                rclk_i,
    input  logic                rarst_ni,
    output logic [WIDTH-1:0]    stream_o
);

logic [LEVELS-1:0] [WIDTH-1:0]sync_q,sync_d;

always_comb begin
    sync_d = {sync_q[LEVELS-2:1],stream_i};
end

always_ff @(posedge wclk_i or negedge warst_ni) begin
    if (!warst_ni) begin
        sync_q[0] <= '0;
    end else begin
        sync_q[0] <= sync_d[0];
    end     
end

always_ff @(posedge rclk_i or negedge rclk_i) begin
    if (!rarst_ni) begin
        sync_q[LEVELS-1:1] <= '0;
    end else begin
        sync_q <= sync_d[LEVELS-1:1];
    end     
end
assign stream_o = sync_q[LEVELS-1];
endmodule :async_ff


module async_ff_en  #(
    parameter int unsigned LEVELS = 2,
    parameter int unsigned WIDTH  = 2,
    
)(
    input  logic                wclk_i,
    input  logic                warst_ni,
    input  logic [WIDTH-1:0]    stream_i,
    input  logic                en_i,

    input  logic                rclk_i,
    input  logic                rarst_ni,
    output logic [WIDTH-1:0]    stream_o,
    output logic                en_o
);

logic [LEVELS-1:0] [WIDTH-1:0]sync_data_q,sync_data_d;
logic [LEVELS-1:0] [WIDTH-1:0]sync_en_q,sync_en_d;
logic falling_edge,rising_edge;


edge_detector  #(
    .LEVELS(LEVELS)
) u_edge_detector(
    .clk_i(wclk_i),
    .arst_ni(warst_ni),
    .data_i(en_i),
    .falling_edge_o(falling_edge_o),
    .rising_edge_o(rising_edge_o)
);

always_comb begin
    sync_data_d = {sync_data_q[LEVELS-2:1],stream_i};
end

always_ff @(posedge wclk_i or negedge warst_ni) begin
    if (!warst_ni) begin
        sync_data_q[0] <= '0;
    end else begin
        sync_data_q[0] <= sync_data_d[0];
    end     
end

always_ff @(posedge rclk_i or negedge rclk_i) begin
    if (!rarst_ni) begin
        sync_q[LEVELS-1:1] <= '0;
    end else begin
        sync_data_q <= (rising_edge_o) ? sync_data_d[LEVELS-1:1];
    end     
end
assign stream_o = sync_data_q[LEVELS-1];
endmodule : async_ff_en



module async_ff_en_ack  #(
    parameter int unsigned LEVELS = 2,
    parameter int unsigned WIDTH  = 2,
    
)(
    input  logic                wclk_i,
    input  logic                warst_ni,
    input  logic [WIDTH-1:0]    stream_i,
    input  logic                en_i,
    output logic                ack_o,


    input  logic                rclk_i,
    input  logic                rarst_ni,
    output logic [WIDTH-1:0]    stream_o,
    output logic                en_o
);

logic [LEVELS-1:0] [WIDTH-1:0]sync_data_q,sync_data_d;
logic [LEVELS-1:0] [WIDTH-1:0]sync_en_q,sync_en_d;
logic falling_edge,rising_edge;
logic [LEVELS-1:0] feed_back_q,feed_back_d;


edge_detector  #(
    .LEVELS(LEVELS)
) u_edge_detector(
    .clk_i(wclk_i),
    .arst_ni(warst_ni),
    .data_i(en_i),
    .data_o(feed_back_d[0])
    .falling_edge_o(falling_edge_o),
    .rising_edge_o(rising_edge_o)
);



always_comb begin
    sync_data_d = {sync_data_q[LEVELS-2:1],stream_i};
    feed_back_d =  feed_back_q[LEVELS-2:1];
    
end

always_ff @(posedge wclk_i or negedge warst_ni) begin
    if (!warst_ni) begin
        sync_data_q[0] <= '0;
    end else begin
        sync_data_q[0]          <= sync_data_d[0];
        feed_back_q[LEVELS-1:1] <= feed_back_d;
    end     
end

always_ff @(posedge rclk_i or negedge rclk_i) begin
    if (!rarst_ni) begin
        sync_q[LEVELS-1:1] <= '0;
    end else begin
        sync_data_q    <= (rising_edge_o) ? sync_data_d[LEVELS-1:1];
    end     
end
assign stream_o         = sync_data_q[LEVELS-1];
assign ack_o            = feed_back_q[LEVELS-1];

endmodule : async_ff_en_ack