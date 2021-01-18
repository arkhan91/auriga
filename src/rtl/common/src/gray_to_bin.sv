
// LICENSE
module gray_to_bin  #(
    parameter int unsigned WIDTH = 4
)(

    input logic [WIDTH-1:0 ] gray_data_i,
    output logic [WIDTH-1:0 ] bin_data_o
);
generate;
    for(genvar i=0;i<WIDTH;i++)
    assign bin_data_o[i] = ^gray_data_i[WIDTH-1:i];
    
endgenerate

endmodule 