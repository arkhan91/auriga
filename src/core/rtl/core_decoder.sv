
// LICENSE
import core_pkg::*;
module core_decoder (
    input logic                                clk_i,
    input logic                                arst_ni,
    input logic [31:0]           instruction_i,
    input logic                  instruction_valid_i,
    
    input logic [31:0]           program_cnt_i,


    input logic                  stall_i,
    output logic  [31:0]         alu_operand_a_o,
    output logic  [31:0]         alu_operand_b_o,
    output logic [31:0]          program_cnt_o,
    output logic [31:0]          sign_extended_o,
    input logic [4:0] rd_addr_i,
    input logic [31:0] rd_data_i,
    output core_pkg::core_ctrl_t core_ctrl_o
    );
    
    logic [11:0] imemediate_val;
    logic operand_sel_0;
    logic operand_sel_1;
    logic [31:0]           program_cnt_q;

    core_pkg::opcode_e      opcode;
    core_pkg::alu_op_t      alu_op;
    core_pkg::load_op_t     load_op;
    core_pkg::store_op_t    store_op;
    core_pkg::branch_op_t   branch_op;


    core_pkg::core_ctrl_t core_ctrl_d,core_ctrl_q;
    
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [11:0] imm12;
    logic [11:0] imm5;
    logic [5:0] rs1_addr;
    logic [5:0] rs2_addr;
    logic [5:0] rd_addr;

    logic                         rd_en;
    logic                         stall;  


    assign alu_op     = alu_op_t'(instruction_i[14:12]);
    assign load_op    = load_op_t'(instruction_i[14:12]);
    assign store_op   = store_op_t'(instruction_i[14:12]);
    assign branch_op  = branch_op_t'(instruction_i[14:12]);

    assign opcode     = opcode_e'(instruction_i[6:0]);
    // SIGN EXTENDED
    assign imemediate_val[11:5]     =  instruction_i[31:25];
    assign imemediate_val[4:0]      =  (opcode==STORE) ? instruction_i[31:25] : instruction_i[11:7];

    assign rd_en = 1'b1;
    assign stall = 1'b0;
    core_regfile u_core_regfile (
      .clk_i(clk_i),
      .arst_ni(arst_ni),
      .rs0_addr_i(core_ctrl_d.addr.rs1_addr),
      .rs0_data_o(rs0_data),
      .rs1_addr_i(core_ctrl_d.addr.rs2_addr),
      .rs1_data_o(rs1_data),
      .rd_we_i(rd_en),
      .rd_addr_i(rd_addr_i),
      .rd_data_i(rd_data_i)
      );



      assign alu_operand_a_o = (core_ctrl_q.op_mux_sel_0==REG_OPERAND) ? rs0_data : core_ctrl_q.sign_extended;
      assign alu_operand_b_o = (core_ctrl_q.op_mux_sel_0==REG_OPERAND) ? rs1_data : core_ctrl_q.sign_extended;

      
    always_comb begin // operand selector
      rs2_addr = instruction_i[24:20];
      rs1_addr = instruction_i[19:15];
      rd_addr  = instruction_i[11:7];

      core_ctrl_d.addr.rs2_addr  = register_file_t'(rs2_addr);
      core_ctrl_d.addr.rs1_addr  = register_file_t'(rs1_addr);
      core_ctrl_d.addr.rd_addr   = register_file_t'(rd_addr);
    end

    // Instruction decoder 
    always_comb begin 
      
        core_ctrl_d.alu_op         = ADD_SUB;
        core_ctrl_d.op_mux_sel_0   = REG_OPERAND;
        core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
        core_ctrl_d.load_op        = LB;
        core_ctrl_d.store_op       = SB;
        core_ctrl_d.branch_op      = BEQ;
        core_ctrl_d.invert         = '0;
        core_ctrl_d.alu_sel        = '0;
        core_ctrl_d.load_sel       = '0;
        core_ctrl_d.store_sel      = '0;
        core_ctrl_d.branch_sel     = '0;
        core_ctrl_d.addr           = '0;
        core_ctrl_d.sign_extended  = $signed(imemediate_val);

        unique case (opcode)

        /*LUI instruction: */
        /*AUIPC instruction: */

        /*jump instruction: */
        /*branch instruction: */


        /*Store instruction: */
        STORE : begin 
          core_ctrl_d.store_sel        = '1;
          case(store_op) 
          SB: begin 
            core_ctrl_d.store_op        = SB;
            core_ctrl_d.op_mux_sel_0   = REG_OPERAND;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
          end 
          
          SH: begin 
            core_ctrl_d.store_op         = SH;
            core_ctrl_d.op_mux_sel_0   = REG_OPERAND;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
          end 
          
          SW: begin 
            core_ctrl_d.store_op         = SW;
            core_ctrl_d.op_mux_sel_0   = REG_OPERAND;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
          end 
         endcase
          
        end
        
        /*load instruction: */
        LOAD : begin
          core_ctrl_d.load_sel        = '1;
          case(load_op) 
          LB: begin 
            core_ctrl_d.load_op        = LB;
            core_ctrl_d.op_mux_sel_0   = IMEM;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
          end 
          
          LH: begin 
            core_ctrl_d.load_op        = LH;
            core_ctrl_d.op_mux_sel_0   = IMEM;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
          end 
          
          LW: begin 
            core_ctrl_d.load_op        = LW;
            core_ctrl_d.op_mux_sel_0   = IMEM;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
          end 
          
          LD: begin 
            core_ctrl_d.load_op        = LD;
            core_ctrl_d.op_mux_sel_0   = IMEM;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
          end 
          
          LBU: begin 
            core_ctrl_d.load_op        = LBU;
            core_ctrl_d.op_mux_sel_0   = IMEM;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
          end 
          
          LHU: begin 
            core_ctrl_d.load_op        = LHU;
            core_ctrl_d.op_mux_sel_0   = IMEM;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;              
          end
          
          LWU: begin 
            core_ctrl_d.load_op        = LWU;
            core_ctrl_d.op_mux_sel_0   = IMEM; 
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;              
          end  
         endcase
          
        end
        
        /*ALU imediate instruction: */
        ALU_OP_IMM : begin 
        core_ctrl_d.alu_sel          = 1'b1;
          case(alu_op) 
        ADD_SUB: begin 
          core_ctrl_d.alu_op         = ADD_SUB;
          core_ctrl_d.op_mux_sel_0   = IMEM;
          core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
        end 
        
        SLL: begin 
          core_ctrl_d.alu_op         = SLL;
          core_ctrl_d.op_mux_sel_0   = IMEM;
          core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
        end 
        
        SRL_SRA: begin 
          core_ctrl_d.alu_op         = SRL_SRA;
          core_ctrl_d.op_mux_sel_0   = IMEM;
          core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
          core_ctrl_d.invert         = instruction_i[30];
        end 
        
        SLT: begin 
          core_ctrl_d.alu_op         = SLT;
          core_ctrl_d.op_mux_sel_0   = IMEM;
          core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
        end 
        
        SLTU: begin 
          core_ctrl_d.alu_op         = SLT;
          core_ctrl_d.op_mux_sel_0   = IMEM;
          core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
        end 
        
        XOR: begin 
          core_ctrl_d.alu_op         = XOR;
          core_ctrl_d.op_mux_sel_0   = IMEM;
          core_ctrl_d.op_mux_sel_1   = REG_OPERAND;              
        end
        
        OR: begin 
          core_ctrl_d.alu_op         = OR;
          core_ctrl_d.op_mux_sel_0   = IMEM; 
          core_ctrl_d.op_mux_sel_1   = REG_OPERAND;              
        end  
       endcase
        
      end
      /*ALU instruction: */
      ALU_OP : begin   
        core_ctrl_d.alu_sel        = 1'b1;

        case(alu_op) 
          ADD_SUB: begin 
            core_ctrl_d.alu_op         = ADD_SUB;
            core_ctrl_d.op_mux_sel_0   = REG_OPERAND;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
            core_ctrl_d.invert         = instruction_i[30];

          end 
          
          SLL: begin 
            core_ctrl_d.alu_op         = SLL;
            core_ctrl_d.op_mux_sel_0   = IMEM;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
          end 
          
          SRL_SRA: begin 
            core_ctrl_d.alu_op         = SRL_SRA;
            core_ctrl_d.op_mux_sel_0   = IMEM;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
            core_ctrl_d.invert         = instruction_i[30];
          end 
          

              
          SLT: begin 
            core_ctrl_d.alu_op         = SLT;
            core_ctrl_d.op_mux_sel_0   = REG_OPERAND;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
          end 
          
          SLTU: begin 
            core_ctrl_d.alu_op         = SLT;
            core_ctrl_d.op_mux_sel_0   = REG_OPERAND;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;
          end 
          
          XOR: begin 
            core_ctrl_d.alu_op         = XOR;
            core_ctrl_d.op_mux_sel_0   = REG_OPERAND;
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;              
          end
          
          OR: begin 
            core_ctrl_d.alu_op         = OR;
            core_ctrl_d.op_mux_sel_0   = REG_OPERAND; 
            core_ctrl_d.op_mux_sel_1   = REG_OPERAND;              
          end  
        endcase
        end
        
        /*Fence instruction: */
        /*Pause instruction: */
        /*CSR instruction: */

        endcase
      end



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

endmodule : core_decoder
