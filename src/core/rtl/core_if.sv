/*
MIT License

Copyright (c) 2020 arkhan91

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/
/***************************************************************************************
File name     : branch_sel.sv
Project       : Auriga
Language      : SystemVerilog
Description   : Branch selector
***************************************************************************************/

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