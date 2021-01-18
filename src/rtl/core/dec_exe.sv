
dec_exe #(

  )(
  
     // REGFILE
  
    input core_pkg::instruction          instruction_i,

    input  logic  [DATA_WIDTH-1:0]       woperands_i,
    output logic [1:0] [DATA_WIDTH-1:0]  roperands_o,
    input  logic [DATA_WIDTH-1:0]        pc_i,
    output logic [DATA_WIDTH-1:0]        pc_o,
    output logic [DATA_WIDTH-1:0]        imemediated_o,



    );

decoder u_decoder();
regfile u_regfile();


endmodule: dec_exe