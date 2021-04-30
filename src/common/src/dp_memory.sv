
// LICENSE
module dp_memory  #(
    parameter int unsigned DATA_WIDTH = 32,
    parameter int unsigned DEPTH      = 1024

)(
    input logic     clk_i,

    input logic     we_i,
    input logic     [DATA_WIDTH-1:0] wdata_i,
    input logic     [$clog2(DEPTH)-1:0] waddr_i,

    input logic     re_i,
    input logic     [$clog2(DEPTH)-1:0] raddr_i,
    output logic    [DATA_WIDTH-1:0] rdata_o,
);

localparam ADDR_WIDTH = $clog2(DEPTH);
logic [DATA_WIDTH-1:0] dp_ram [ADDR_WIDTH-1:0];


always_ff @(posedge clk_i ) begin
    if (we_i)
        dp_ram[waddr_i] <= wdata_i; 
end

always_ff @(posedge clk_i ) begin
    if (re_i)
        rdata_o <= dp_ram[raddr_i];end
end
endmodule :dp_memory