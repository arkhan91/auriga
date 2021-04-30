
// LICENSE
module bin_to_gray  #(
    parameter int unsigned WIDTH = 4
)(

    input logic [WIDTH-1:0 ] bin_data_i,
    output logic [WIDTH-1:0 ] gray_data_o
);

assign gray_data_o = bin_data_i ^ (bin_data_i>>1);

endmodule 