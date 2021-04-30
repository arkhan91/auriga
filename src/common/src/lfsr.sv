

// LICENSE
module sram  #(
    parameter int unsigned LFSR_WIDTH = 32,
    parameter int unsigned DATA_WIDTH = 8
    
)(
    input logic                             clk_i,
    input logic                             arst_ni,
    input logic                             en_i,
    output logic    [DATA_WIDTH-1:0]        data_o
);

localparam int unsigned LOG_WIDTH = $clog2(LFSRWIDTH);
logic [LFSRWIDTH-1:0] ram [ADDR_WIDTH-1:0];
logic [ADDR_WIDTH-1:0] raddr_q;

output logic    [LFSRWIDTH-1:0]         shift_q,shift_d,

always_comb begin
    automatic logic shift_in;
    shift_in = !(shift_q[7] ^ shift_q[3] ^ shift_q[2] ^ shift_q[1]]);
    shift_d =  {shift_q[6:0],shift_in};
    if (en_i)
        shift_d =  {shift_in}
    be_o ='b0;
    be_o [shift_q[LOG_WIDTH-1:0]] =1'b0;
    
    rdata_o  = shift_q;  
end

always_ff @(posedge clk_i ) begin
    if (!we_i)
        shift_q <= SEED;
    else 
        shift_q <= shift_d;
end

// pragama translate_off
initial begin
    assert(LFSRWIDTH<=8) else $fatal(1,"%d-LFSR has must have Width %d",LFSRWIDTH,LFSRWIDTH);
end
// pragama translate_on
endmodule