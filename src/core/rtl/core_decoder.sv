
// LICENSE
import core_pkg::*;
module core_decoder (
    input logic                  clk_i,
    input logic                  arst_ni,
    input logic [31:0]           instruction_i,
    input logic                  instruction_valid_i,

    input logic [31:0]           id_pc_i,
    input logic                  stall_i,
    output logic [31:0]          sign_extended_o,
    output core_pkg::core_ctrl_t core_ctrl
    );
    
    logic [11:0] imemediate_val;
    core_pkg::Rtype_inst_t  rtype_inst;
    core_pkg::Itype_inst_t  itype_inst;
    core_pkg::opcode_e      opcode;
    
    core_pkg::alu_op_t      func3;

    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [11:0] imm12;
    logic [11:0] imm5;

    assign opcode     = instruction_i[6:0];
    assign func3      = instruction_i[14:12];



  // exceptions
    

    always_comb begin

        core_ctrl.alu_op         = ADD;
        core_ctrl.op_mux_sel_0   = REG_OPERAND;
        core_ctrl.op_mux_sel_1   = REG_OPERAND;
        unique case (opcode)
   /*
          LUI: begin 
                  core_ctrl.alu_op         = SUB;
                  core_ctrl.op_mux_sel_0   = IMEM;
                  core_ctrl.op_mux_sel_1   = REG_OPERAND;
              end  
            
          AUIPC: begin 
                  core_ctrl.alu_op         = SUB;
                  core_ctrl.op_mux_sel_0   = IMEM;
                  core_ctrl.op_mux_sel_1   = REG_OPERAND;
                end  

          JAL: begin 
                  core_ctrl.alu_op                    = SUB;
                  core_ctrl.op_mux_sel_0   = IMEM;
                  core_ctrl.op_mux_sel_1   = REG_OPERAND;
              end  

          JALR: begin 
                  core_ctrl.alu_op                    = SUB;
                  core_ctrl.op_mux_sel_0   = IMEM;
                  core_ctrl.op_mux_sel_1   = REG_OPERAND;
                end  
                
          ////////////////// BRANCH 
          BEQ: begin 
                  core_ctrl.alu_op                    = SUB;
                  core_ctrl.op_mux_sel_0   = IMEM;
                  core_ctrl.op_mux_sel_1   = REG_OPERAND;
              end  
            
          BNE: begin 
              core_ctrl.alu_op                    = SUB;
              core_ctrl.op_mux_sel_0   = IMEM;
              core_ctrl.op_mux_sel_1   = REG_OPERAND;
            end  
          
          BLT: begin 
              core_ctrl.alu_op                    = SUB;
              core_ctrl.op_mux_sel_0   = IMEM;
              core_ctrl.op_mux_sel_1   = REG_OPERAND;
            end  
          
          BGE: begin 
              core_ctrl.alu_op                    = SUB;
              core_ctrl.op_mux_sel_0   = IMEM;
              core_ctrl.op_mux_sel_1   = REG_OPERAND;
            end  

          BLTU: begin 
              core_ctrl.alu_op                    = SUB;
              core_ctrl.op_mux_sel_0   = IMEM;
              core_ctrl.op_mux_sel_1   = REG_OPERAND;
            end  

          BGEU: begin 
              core_ctrl.alu_op                    = SUB;
              core_ctrl.op_mux_sel_0   = IMEM;
              core_ctrl.op_mux_sel_1   = REG_OPERAND;
            end  
            
          

////////////////// LOAD STORE
          LB: begin 
              core_ctrl.alu_op                    = SUB;
              core_ctrl.op_mux_sel_0   = IMEM;
              core_ctrl.op_mux_sel_1   = REG_OPERAND;
            end  


          LH: begin 
              core_ctrl.alu_op                    = SUB;
              core_ctrl.op_mux_sel_0   = IMEM;
              core_ctrl.op_mux_sel_1   = REG_OPERAND;
            end  

          LW: begin 
              core_ctrl.alu_op                    = SUB;
              core_ctrl.op_mux_sel_0   = IMEM;
              core_ctrl.op_mux_sel_1   = REG_OPERAND;
            end  

          LBU: begin 
              core_ctrl.alu_op                    = SUB;
              core_ctrl.op_mux_sel_0   = IMEM;
              core_ctrl.op_mux_sel_1   = REG_OPERAND;
            end  
                  
          LHU: begin 
              core_ctrl.alu_op                    = SUB;
              core_ctrl.op_mux_sel_0   = IMEM;
              core_ctrl.op_mux_sel_1   = REG_OPERAND;
            end 
            
          SB: begin 
              core_ctrl.alu_op                    = SUB;
              core_ctrl.op_mux_sel_0   = IMEM;
              core_ctrl.op_mux_sel_1   = REG_OPERAND;
            end
                      
                      
          SH: begin 
              core_ctrl.alu_op                    = SUB;
              core_ctrl.op_mux_sel_0   = IMEM;
              core_ctrl.op_mux_sel_1   = REG_OPERAND;
            end  

          SW: begin 
              core_ctrl.alu_op                    = SUB;
              core_ctrl.op_mux_sel_0   = IMEM;
              core_ctrl.op_mux_sel_1   = REG_OPERAND;
            end  
          */
////////////////// IMEDIATE ARTHMATICS 
      OPCODE_OP_IMM : begin
       case(func3) 
        ADD: begin 
          core_ctrl.alu_op         = ADD;
          core_ctrl.op_mux_sel_0   = IMEM;
          core_ctrl.op_mux_sel_1   = REG_OPERAND;
          core_ctrl.addr.rs1_addr  = REG_OPERAND;

        end 
        
        SLL: begin 
          core_ctrl.alu_op         = SLL;
          core_ctrl.op_mux_sel_0   = IMEM;
          core_ctrl.op_mux_sel_1   = REG_OPERAND;
        end 
        
        SRL: begin 
          core_ctrl.alu_op         = SRL;
          core_ctrl.op_mux_sel_0   = IMEM;
          core_ctrl.op_mux_sel_1   = REG_OPERAND;
        end 
        

            
        SLT: begin 
          core_ctrl.alu_op         = SLT;
          core_ctrl.op_mux_sel_0   = IMEM;
          core_ctrl.op_mux_sel_1   = REG_OPERAND;
        end 
        
        SLTU: begin 
          core_ctrl.alu_op         = SLT;
          core_ctrl.op_mux_sel_0   = IMEM;
          core_ctrl.op_mux_sel_1   = REG_OPERAND;
        end 
        
        XOR: begin 
          core_ctrl.alu_op         = XOR;
          core_ctrl.op_mux_sel_0   = IMEM;
          core_ctrl.op_mux_sel_1   = REG_OPERAND;              
        end
        
        OR: begin 
          core_ctrl.alu_op         = OR;
          core_ctrl.op_mux_sel_0   = IMEM; 
          core_ctrl.op_mux_sel_1   = REG_OPERAND;              
        end  
       endcase
        
      end
        
////////////////// REG-REG ARTHMATICS 
      OPCODE_OP : begin
        case(func3) 
          ADD: begin 
            core_ctrl.alu_op         = ADD;
            core_ctrl.op_mux_sel_0   = REG_OPERAND;
            core_ctrl.op_mux_sel_1   = REG_OPERAND;
          end 
          
          SLL: begin 
            core_ctrl.alu_op         = SLL;
            core_ctrl.op_mux_sel_0   = IMEM;
            core_ctrl.op_mux_sel_1   = REG_OPERAND;
          end 
          
          SRL: begin 
            core_ctrl.alu_op         = SRL;
            core_ctrl.op_mux_sel_0   = IMEM;
            core_ctrl.op_mux_sel_1   = REG_OPERAND;
          end 
          

              
          SLT: begin 
            core_ctrl.alu_op         = SLT;
            core_ctrl.op_mux_sel_0   = REG_OPERAND;
            core_ctrl.op_mux_sel_1   = REG_OPERAND;
          end 
          
          SLTU: begin 
            core_ctrl.alu_op         = SLT;
            core_ctrl.op_mux_sel_0   = REG_OPERAND;
            core_ctrl.op_mux_sel_1   = REG_OPERAND;
          end 
          
          XOR: begin 
            core_ctrl.alu_op         = XOR;
            core_ctrl.op_mux_sel_0   = REG_OPERAND;
            core_ctrl.op_mux_sel_1   = REG_OPERAND;              
          end
          
          OR: begin 
            core_ctrl.alu_op         = OR;
            core_ctrl.op_mux_sel_0   = REG_OPERAND; 
            core_ctrl.op_mux_sel_1   = REG_OPERAND;              
          end  
        endcase
        end
                
        endcase
    end
    assign core_ctrl.addr.rs1_addr  = instruction_i[19:15];
    assign core_ctrl.addr.rs2_addr  = instruction_i[24:20];
    assign core_ctrl.addr.rd_addr   = instruction_i[11:7];
    // SIGN EXTENDED
    assign imemediate_val[11:5]     =  instruction_i[31:25];
    assign imemediate_val[4:0]      =  (instruction_i[6:0]==OPCODE_STORE) ? instruction_i[31:25] : instruction_i[11:7];
    assign core_ctrl.sign_extended  =  $signed(imemediate_val);
    assign core_ctrl.invert         =  instruction_i[30];
    // CSR

    
endmodule : core_decoder

