module spi_slave (
    input logic spi_clk_i,
    input logic cs_n_i,
    input logic rst_n_i,
    input logic mosi_i,
    input logic miso_i,
    
    input logic [7:0] data_i,
    output logic [7:0] data_o
);

logic [7:0] data_d;
logic [7:0] data_q;



/// Serial to Parallel 
  always_comb begin
    shift_done_d = 1'b0;
    if (!cs_n)
      unique case (bit_cnt_q)
        'd7,'d6,'d5,'d4,'d3,'d2,'d1:
            data_d = {data_q[6:0],mosi_i};
        'd0: begin
            data_d = {data_q[6:0],mosi_i};
            shift_done_d = 1'b1;
        end
    endcase
  end
    
endmodule