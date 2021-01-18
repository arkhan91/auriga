interface inst_memory_if #(
    parameter integer unsigned    ADDR_WIDTH        = 32,
    parameter integer unsigned    DATA_WIDTH        = 32   
    )();
    logic req;
    logic grnt;
    logic [ADDR-1:0] addr;
    logic valid;
    logic [DATA_WIDTH-1:0] data;

    modport master(
        output req,
        input  grnt,
        output addr,
        output valid,
        output data
    );

    modport slave(
        input req,
        output  grnt,
        input addr,
        input valid,
        input data
    );


endinterface //inst_memory_if

interface data_memory_if #(
    parameter integer unsigned    ADDR_WIDTH        = 32,
    parameter integer unsigned    DATA_WIDTH        = 32,
    parameter integer unsigned    BEAT_SIZE         = 8
        
    )();
    logic req;
    logic grnt;
    logic [ADDR-1:0] addr;
    logic valid;
    logic [DATA_WIDTH-1:0] rdata;
    logic ren;
    logic [DATA_WIDTH-1:0] wdata;
    logic wen;
    logic [((DATA_WIDTH)/BEATSIZE)-1:0] beat;


    modport master(
        output req,
        input  grnt,
        output addr,
        output valid,
        output wdata,
        output wen,
        input  rdata,
        output ren,
        output beat,





    );

    modport slave(
        input req,
        output  grnt,
        input addr,
        input valid,
        input wdata,
        input wen,
        output  rdata,
        input ren,
        input beat,
    );


endinterface //memory_if