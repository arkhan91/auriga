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

package core_pkg;

    // Register file typedef
    typedef enum logic [4:0] {
        x0 = 'd0, x1 = 'd1, x2 = 'd2, x3 = 'd3, x4 = 'd4,
        x5 = 'd5, x6 = 'd6, x7 = 'd7, x8 = 'd8, x9 = 'd9,
        x10 = 'd10, x11 = 'd11, x12 = 'd12, x13 = 'd13, x14 = 'd14,
        x15 = 'd15, x16 = 'd16, x17 = 'd17, x18 = 'd18, x19 = 'd19,
        x20 = 'd20, x21 = 'd21, x22 = 'd22, x23 = 'd23, x24 = 'd24,
        x25 = 'd25, x26 = 'd26, x27 = 'd27, x28 = 'd28, x29 = 'd29,
        x30 = 'd30, x31 = 'd31
    } register_file_t;

    // Opcodes
    typedef enum logic [6:0] {
        LUI      = 7'b0110111,
        AUIPC    = 7'b0010111,
        JAL      = 7'b1101111,
        JALR     = 7'b1100111,
        BRANCH   = 7'b1100011,
        LOAD     = 7'b0000011,
        STORE    = 7'b0100011,
        OP_IMM   = 7'b0010011,
        OP       = 7'b0110011,
        MISC_MEM = 7'b0001111,
        SYSTEM   = 7'b1110011
    } opcode_e;

    // ALU Operations
    typedef enum logic [2:0] {
        ADD_SUB  = 3'b000,
        SLL      = 3'b001,
        SLT      = 3'b010,
        SLTU     = 3'b011,
        XOR      = 3'b100,
        SRL_SRA  = 3'b101,
        OR       = 3'b110,
        AND      = 3'b111
    } alu_op_t;

    // Load Operations
    typedef enum logic [2:0] {
        LB  = 3'b000,
        LH  = 3'b001,
        LW  = 3'b010,
        LBU = 3'b100,
        LHU = 3'b101
    } load_op_t;

    // Store Operations
    typedef enum logic [2:0] {
        SB  = 3'b000,
        SH  = 3'b001,
        SW  = 3'b010
    } store_op_t;

    // Branch Operations
    typedef enum logic [2:0] {
        BEQ  = 3'b000,
        BNE  = 3'b001,
        BLT  = 3'b100,
        BGE  = 3'b101,
        BLTU = 3'b110,
        BGEU = 3'b111
    } branch_op_t;

    // Core Parameters
    localparam int unsigned ALU_OP_BITS = 3;
    localparam int unsigned OP_BITS = 4;

    // Operand Selection
    typedef enum logic [1:0] {
        IMEM,
        REG_OPERAND,
        BYPASS
    } operand_sel_t;

    // Register Address
    typedef struct packed {
        register_file_t rs1_addr;
        register_file_t rs2_addr;
        register_file_t rd_addr;
    } reg_addr_t;

    // Core Control Signals
    typedef struct packed {
        operand_sel_t  op_mux_sel_0;
        operand_sel_t  op_mux_sel_1;
        alu_op_t       alu_op;
        logic          alu_sel;
        load_op_t      load_op;
        store_op_t     store_op;
        logic          load_sel;
        logic          store_sel;
        branch_op_t    branch_op;
        logic          branch_sel;
        logic          invert;
        reg_addr_t     addr;
        logic [31:0]   sign_extended;
    } core_ctrl_t;

endpackage: core_pkg
