
// LICENSE
module counter  #(
    parameter int unsigned WIDTH  = 4
    
)(
    input logic clk_i,
    input logic arst_ni,
    input logic en_i,
    input logic load_i,
    input logic type_i,
    input logic [WIDTH-1:0] data_i,
    output logic [WIDTH-1:0] data_o,
    output logic over_flow_o
);


logic  [WIDTH:0] cnt_d,cnt_q;
always_comb begin
    if (load_i)
        cnt_d <= data_i;
    else begin
        if (type_i)
            cnt_d <= cnt_q + 1'b1;
        else
            cnt_d <= cnt_q - 1'b1;
    end
end
always_ff @(posedge clk_i or negedge arst_ni) begin
    if (!arst_ni) begin
        cnt_q <= '0;
    end else begin
        cnt_q <= cnt_d;
    end
        
end

assign over_flow_o = cnt_q[WIDTH];
assign data_o = cnt_q[WIDTH-1:0];
endmodule


module counter_val  #(
    parameter int unsigned DEPTH  = 4,
    parameter int unsigned WIDTH  = $clog2(DEPTH)
    
)(
    input logic clk_i,
    input logic arst_ni,
    input logic en_i,
    input logic load_i,
    input logic type_i,
    input logic [WIDTH-1:0] data_i,
    output logic [WIDTH-1:0] data_o,
    output logic over_flow_o
);


logic  [WIDTH:0] cnt_d,cnt_q;
always_comb begin
    if (load_i)
        cnt_d <= data_i;
    else begin
        if (type_i)
            cnt_d <= (cnt_q==DEPTH) ? '0:cnt_q + 1'b1;
        else
            cnt_d <= (cnt_q =='0) ? cnt_q - 1'b1 : $unsigned(DEPTH);
    end
end
always_ff @(posedge clk_i or negedge arst_ni) begin
    if (!arst_ni) begin
        cnt_q <= '0;
    end else begin
        cnt_q <= cnt_d;
    end
        
end

assign over_flow_o = cnt_q==$unsigned(DEPTH);
assign data_o      = cnt_q[WIDTH-1:0];
endmodule : counter_val


module counter_up  #(
    parameter int unsigned DEPTH  = 4,
    parameter int unsigned WIDTH  = $clog2(DEPTH)
    
)(
    input logic clk_i,
    input logic arst_ni,
    input logic en_i,
    output logic [WIDTH-1:0] data_o,
);

logic  [WIDTH:0] cnt_d,cnt_q;
always_comb begin
    cnt_d <= (cnt_q==DEPTH) ? '0:cnt_q + 1'b1;   
end
always_ff @(posedge clk_i or negedge arst_ni) begin
    if (!arst_ni) begin
        cnt_q <= '0;
    end else begin
        cnt_q <= (en_i)? cnt_d:cnt_q;
    end
        
end
assign data_o      = cnt_q[WIDTH-1:0];
endmodule : counter_up