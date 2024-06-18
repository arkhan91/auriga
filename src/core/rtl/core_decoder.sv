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

import core_pkg::*;

module core_decoder (
    input logic                clk_i,
    input logic                arst_ni,
    input logic [31:0]         instruction_i,
    input logic                instruction_valid_i,
    input logic [31:0]         program_cnt_i,
    input logic                stall_i,
    output logic [31:0]        alu_operand_a_o,
    output logic [31:0]        alu_operand_b_o,
    output logic [31:0]        program_cnt_o,
    output logic [31:0]        sign_extended_o,
    input logic [4:0]          rd_addr_i,
    input logic [31:0]         rd_data_i,
    output core_pkg::core_ctrl_t core_ctrl_o
);

    // Internal signals
    logic [31:0] rs0_data, rs1_data;
    core_pkg::opcode_e opcode;
    core_pkg::alu_op_t alu_op;
    core_pkg::load_op_t load_op;
    core_pkg::store_op_t store_op;
    core_pkg::branch_op_t branch_op;

    core_pkg::core_ctrl_t core_ctrl_d, core_ctrl_q;

    logic [4:0] rs1_addr, rs2_addr, rd_addr;
    logic [11:0] imm12;
    logic rd_en;
    logic [31:0]         program_cnt_q;
    // Decode instruction fields
    assign opcode = opcode_e'(instruction_i[6:0]);
    assign alu_op = alu_op_t'(instruction_i[14:12]);
    assign load_op = load_op_t'(instruction_i[14:12]);
    assign store_op = store_op_t'(instruction_i[14:12]);
    assign branch_op = branch_op_t'(instruction_i[14:12]);

    // Sign extension
    assign imm12 = instruction_i[31:20];

    // Register file instantiation
    core_regfile u_core_regfile (
        .clk_i(clk_i),
        .arst_ni(arst_ni),
        .rsrc0_addr_i(core_ctrl_d.addr.rs1_addr),
        .rsrc0_data_o(rs0_data),
        .rsrc1_addr_i(core_ctrl_d.addr.rs2_addr),
        .rsrc1_data_o(rs1_data),
        .rdes_we_i(rd_en),
        .rdes_addr_i(rd_addr_i),
        .rdes_data_i(rd_data_i)
    );

    // ALU operand selection
    assign alu_operand_a_o = (core_ctrl_q.op_mux_sel_0 == REG_OPERAND) ? rs0_data : core_ctrl_q.sign_extended;
    assign alu_operand_b_o = (core_ctrl_q.op_mux_sel_1 == REG_OPERAND) ? rs1_data : core_ctrl_q.sign_extended;

    // Operand selector
    always_comb begin
        rs1_addr = instruction_i[19:15];
        rs2_addr = instruction_i[24:20];
        rd_addr = instruction_i[11:7];

        core_ctrl_d.addr.rs1_addr = register_file_t'(rs1_addr);
        core_ctrl_d.addr.rs2_addr = register_file_t'(rs2_addr);
        core_ctrl_d.addr.rd_addr = register_file_t'(rd_addr);
    end

    // Instruction decoder
    always_comb begin
        core_ctrl_d.alu_op = ADD_SUB;
        core_ctrl_d.op_mux_sel_0 = REG_OPERAND;
        core_ctrl_d.op_mux_sel_1 = REG_OPERAND;
        core_ctrl_d.load_op = LB;
        core_ctrl_d.store_op = SB;
        core_ctrl_d.branch_op = BEQ;
        core_ctrl_d.invert = '0;
        core_ctrl_d.alu_sel = '0;
        core_ctrl_d.load_sel = '0;
        core_ctrl_d.store_sel = '0;
        core_ctrl_d.branch_sel = '0;
        core_ctrl_d.sign_extended = $signed(imm12);

        unique case (opcode)
            STORE: begin
                core_ctrl_d.store_sel = '1;
                case (store_op)
                    SB: core_ctrl_d.store_op = SB;
                    SH: core_ctrl_d.store_op = SH;
                    SW: core_ctrl_d.store_op = SW;
                endcase
            end
            LOAD: begin
                core_ctrl_d.load_sel = '1;
                case (load_op)
                    LB: core_ctrl_d.load_op = LB;
                    LH: core_ctrl_d.load_op = LH;
                    LW: core_ctrl_d.load_op = LW;
                    LBU: core_ctrl_d.load_op = LBU;
                    LHU: core_ctrl_d.load_op = LHU;
                endcase
            end
            OP_IMM: begin
                core_ctrl_d.alu_sel = 1'b1;
                case (alu_op)
                    ADD_SUB: core_ctrl_d.alu_op = ADD_SUB;
                    SLL: core_ctrl_d.alu_op = SLL;
                    SLT: core_ctrl_d.alu_op = SLT;
                    SLTU: core_ctrl_d.alu_op = SLTU;
                    XOR: core_ctrl_d.alu_op = XOR;
                    SRL_SRA: begin
                        core_ctrl_d.alu_op = SRL_SRA;
                        core_ctrl_d.invert = instruction_i[30];
                    end
                    OR: core_ctrl_d.alu_op = OR;
                    AND: core_ctrl_d.alu_op = AND;
                endcase
            end
            OP: begin
                core_ctrl_d.alu_sel = 1'b1;
                case (alu_op)
                    ADD_SUB: begin
                        core_ctrl_d.alu_op = ADD_SUB;
                        core_ctrl_d.invert = instruction_i[30];
                    end
                    SLL: core_ctrl_d.alu_op = SLL;
                    SLT: core_ctrl_d.alu_op = SLT;
                    SLTU: core_ctrl_d.alu_op = SLTU;
                    XOR: core_ctrl_d.alu_op = XOR;
                    SRL_SRA: begin
                        core_ctrl_d.alu_op = SRL_SRA;
                        core_ctrl_d.invert = instruction_i[30];
                    end
                    OR: core_ctrl_d.alu_op = OR;
                    AND: core_ctrl_d.alu_op = AND;
                endcase
            end
            BRANCH: begin
                core_ctrl_d.branch_sel = 1'b1;
                case (branch_op)
                    BEQ: core_ctrl_d.branch_op = BEQ;
                    BNE: core_ctrl_d.branch_op = BNE;
                    BLT: core_ctrl_d.branch_op = BLT;
                    BGE: core_ctrl_d.branch_op = BGE;
                    BLTU: core_ctrl_d.branch_op = BLTU;
                    BGEU: core_ctrl_d.branch_op = BGEU;
                endcase
            end
            // Add other instruction types here (e.g., LUI, AUIPC, JUMP, SYSTEM, etc.)
            default: begin
                core_ctrl_d.alu_op = ADD_SUB;
                core_ctrl_d.op_mux_sel_0 = REG_OPERAND;
                core_ctrl_d.op_mux_sel_1 = REG_OPERAND;
                core_ctrl_d.load_op = LB;
                core_ctrl_d.store_op = SB;
                core_ctrl_d.branch_op = BEQ;
                core_ctrl_d.invert = '0;
                core_ctrl_d.alu_sel = '0;
                core_ctrl_d.load_sel = '0;
                core_ctrl_d.store_sel = '0;
                core_ctrl_d.branch_sel = '0;
                core_ctrl_d.sign_extended = $signed(imm12);
            end
        endcase
    end

    // Flip-flops to store control signals and program counter
    always_ff @(posedge clk_i or negedge arst_ni) begin
        if (!arst_ni) begin
            core_ctrl_q   <= '0;
            program_cnt_q <= '0;
        end else begin
            core_ctrl_q   <= core_ctrl_d;
            program_cnt_q <= program_cnt_i;
        end
    end

    assign core_ctrl_o = core_ctrl_q;
    assign program_cnt_o = program_cnt_q;

endmodule: core_decoder