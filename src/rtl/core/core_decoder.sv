
// LICENSE
import core_pkg::*;
module core_decoder (
    input logic                  clk_i,
    input logic                  arst_ni,
    input logic [31:0]           instruction_i,
    output logic [31:0]          sign_extended_o,
    core_pkg::alu_op_t           alu_op,
    output  logic [1:0] [4:0]    raddr_i,
    output  logic [1:0]          ren_i,
    output  logic  [4:0]         waddr_i,
    output  logic                wen_i
    );
    
    logic [11:0] imemediate_val;
    core_pkg::rtype_inst_t  rtype_inst;
    core_pkg::itype_inst_t  itype_inst;
    core_pkg::core_ctrl_t   core_ctrl;
    core_pkg::opcode_e      opcode;
    logic [2:0] funct3;
    logic [6:0] funct7;
    logic [11:0] imm12;
    logic [11:0] imm5;

    assign opcode     = instruction_i[6:0];
    assign raddr_i[0] = instruction_i[19:15];
    assign raddr_i[1] = instruction_i[24:20];
    assign waddr_i    = instruction_i[11:7];

    

    always_comb begin

        alu_op     = ALU_OP_ADD;

        unique case (opcode)
          ////////////////// JUMPs 
          LUI: begin 
              alu_op                    = SUB;
              core_ctrl.alu_mux_sel_0   = IMEM;
              core_ctrl.alu_mux_sel_1   = REG_OPERAND;
            end  
            
          AUIPC: begin 
              alu_op                    = SUB;
              core_ctrl.alu_mux_sel_0   = IMEM;
              core_ctrl.alu_mux_sel_1   = REG_OPERAND;
              end  

          JAL: begin 
            alu_op                    = SUB;
            core_ctrl.alu_mux_sel_0   = IMEM;
            core_ctrl.alu_mux_sel_1   = REG_OPERAND;
            end  

          JALR: begin 
              alu_op                    = SUB;
              core_ctrl.alu_mux_sel_0   = IMEM;
              core_ctrl.alu_mux_sel_1   = REG_OPERAND;
              end  


          ////////////////// BRANCH 
          BEQ: begin 
            alu_op                    = SUB;
            core_ctrl.alu_mux_sel_0   = IMEM;
            core_ctrl.alu_mux_sel_1   = REG_OPERAND;
            end  
            BNE: begin 
              alu_op                    = SUB;
              core_ctrl.alu_mux_sel_0   = IMEM;
              core_ctrl.alu_mux_sel_1   = REG_OPERAND;
              end  
              BLT: begin 
                alu_op                    = SUB;
                core_ctrl.alu_mux_sel_0   = IMEM;
                core_ctrl.alu_mux_sel_1   = REG_OPERAND;
                end  
                BGE: begin 
                  alu_op                    = SUB;
                  core_ctrl.alu_mux_sel_0   = IMEM;
                  core_ctrl.alu_mux_sel_1   = REG_OPERAND;
                  end  

                  BLTU: begin 
                    alu_op                    = SUB;
                    core_ctrl.alu_mux_sel_0   = IMEM;
                    core_ctrl.alu_mux_sel_1   = REG_OPERAND;
                    end  

                    BGEU: begin 
                      alu_op                    = SUB;
                      core_ctrl.alu_mux_sel_0   = IMEM;
                      core_ctrl.alu_mux_sel_1   = REG_OPERAND;
                      end  

////////////////// LOAD STORE
          LB: begin 
            alu_op                    = SUB;
            core_ctrl.alu_mux_sel_0   = IMEM;
            core_ctrl.alu_mux_sel_1   = REG_OPERAND;
            end  


            LH: begin 
              alu_op                    = SUB;
              core_ctrl.alu_mux_sel_0   = IMEM;
              core_ctrl.alu_mux_sel_1   = REG_OPERAND;
              end  


              LW: begin 
                alu_op                    = SUB;
                core_ctrl.alu_mux_sel_0   = IMEM;
                core_ctrl.alu_mux_sel_1   = REG_OPERAND;
                end  

                LBU: begin 
                  alu_op                    = SUB;
                  core_ctrl.alu_mux_sel_0   = IMEM;
                  core_ctrl.alu_mux_sel_1   = REG_OPERAND;
                  end  
                  LHU: begin 
                    alu_op                    = SUB;
                    core_ctrl.alu_mux_sel_0   = IMEM;
                    core_ctrl.alu_mux_sel_1   = REG_OPERAND;
                    end                  
                    SB: begin 
                      alu_op                    = SUB;
                      core_ctrl.alu_mux_sel_0   = IMEM;
                      core_ctrl.alu_mux_sel_1   = REG_OPERAND;
                      end
                      
                      
                      SH: begin 
                        alu_op                    = SUB;
                        core_ctrl.alu_mux_sel_0   = IMEM;
                        core_ctrl.alu_mux_sel_1   = REG_OPERAND;
                        end  

                        SW: begin 
                          alu_op                    = SUB;
                          core_ctrl.alu_mux_sel_0   = IMEM;
                          core_ctrl.alu_mux_sel_1   = REG_OPERAND;
                          end  
////////////////// IMEDIATE ARTHMATICS 

          ADDI: begin 
                alu_op                    = ADD;
                core_ctrl.alu_mux_sel_0   = REG_OPERAND;
                core_ctrl.alu_mux_sel_1   = REG_OPERAND;

              end 

          SLTI: begin 
                alu_op                    = SUB;
                core_ctrl.alu_mux_sel_0   = REG_OPERAND;
                core_ctrl.alu_mux_sel_1   = REG_OPERAND;
              end 

          SLTUI: begin 
                alu_op                    = OR;
                core_ctrl.alu_mux_sel_0   = REG_OPERAND;
                core_ctrl.alu_mux_sel_1   = REG_OPERAND;
                            end 
          XORI: begin 
                alu_op                    = AND;
                core_ctrl.alu_mux_sel_0   = REG_OPERAND;
                core_ctrl.alu_mux_sel_1   = REG_OPERAND;              
              end 
          ORI: begin 
                alu_op                    = XOR;
                core_ctrl.alu_mux_sel_0   = REG_OPERAND; 
                core_ctrl.alu_mux_sel_1   = REG_OPERAND;              
   
          SLLI: begin 
                alu_op                    = ADD;
                core_ctrl.alu_mux_sel_0   = IMEM;
                core_ctrl.alu_mux_sel_1   = REG_OPERAND;

              end 
          SRLI: begin 
                alu_op                    = SUB;
                core_ctrl.alu_mux_sel_0   = IMEM;
                core_ctrl.alu_mux_sel_1   = REG_OPERAND;
              end 
          SRAI: begin 
            alu_op                    = ADD;
            core_ctrl.alu_mux_sel_0   = REG_OPERAND;
            core_ctrl.alu_mux_sel_1   = REG_OPERAND
            end

////////////////// REG-REG ARTHMATICS 
          ADD: begin 
            alu_op                    = SUB;
            core_ctrl.alu_mux_sel_0   = REG_OPERAND;
            core_ctrl.alu_mux_sel_1   = REG_OPERAND;
            end
          SUB: begin 
            alu_op                    = OR;
            core_ctrl.alu_mux_sel_0   = REG_OPERAND;
            core_ctrl.alu_mux_sel_1   = REG_OPERAND;
            end 
          SLL: begin 
            alu_op                    = AND;
            core_ctrl.alu_mux_sel_0   = REG_OPERAND;
            core_ctrl.alu_mux_sel_1   = REG_OPERAND;              
            end 
            SLT: begin 
            alu_op                    = XOR;
            core_ctrl.alu_mux_sel_0   = REG_OPERAND; 
            core_ctrl.alu_mux_sel_1   = REG_OPERAND;              

            SLTU: begin 
            alu_op                    = ADD;
            core_ctrl.alu_mux_sel_0   = IMEM;
            core_ctrl.alu_mux_sel_1   = REG_OPERAND
          end 
          XOR: begin 
            alu_op                    = SUB;
            core_ctrl.alu_mux_sel_0   = IMEM;
            core_ctrl.alu_mux_sel_1   = REG_OPERAND;
            end 
            SRL: begin 
            alu_op                    = SUB;
            core_ctrl.alu_mux_sel_0   = IMEM;
            core_ctrl.alu_mux_sel_1   = REG_OPERAND;
            end 
            SRA: begin 
              alu_op                    = SUB;
              core_ctrl.alu_mux_sel_0   = IMEM;
              core_ctrl.alu_mux_sel_1   = REG_OPERAND;
              end 
            OR: begin 
                alu_op                    = SUB;
                core_ctrl.alu_mux_sel_0   = IMEM;
                core_ctrl.alu_mux_sel_1   = REG_OPERAND;
                end
            AND: begin 
                  alu_op                    = SUB;
                  core_ctrl.alu_mux_sel_0   = IMEM;
                  core_ctrl.alu_mux_sel_1   = REG_OPERAND;
                  end  
                        
            
        endcase
    end

    // SIGN EXTENDED
    assign imemediate_val[11:5]  =  instruction_i[31:25];
    assign imemediate_val[4:0]   =  (instruction_i[6:0]==STORE) ? instruction_i[31:25] : instruction_i[11:7];
    assign sign_extended_o =  $signed(imemediate_val);



    
endmodule : core_decoder

/*

        unique case (opcode)
            OPCODE_OP: begin // ALU
                unique case 
                    
            end
            OPCODE_LOAD: begin
                
            end
            OPCODE_ALU: begin
              unique case({rtype_inst.funct7[6:5],rtype_inst.funct3})
                {2'b00,ADD} : begin 
                                alu_op                = ALU_OP_ADD;
                                core_ctrl.regselect   = REG_OPERAND2;
                              end 
                {2'b01,ADD} : begin 
                                alu_op                = ALU_OP_ADD;
                                core_ctrl.regselect   = REG_OPERAND2;

                                core_ctrl.rs1_alu_mux = 1'b0;
                                core_ctrl.rs2_alu_mux = 1'b0; 

                            end 
                {2'b00,SLL} : begin 
                                alu_op.sub            = 1'b1;
                                alu_op.bitwise        = 2'b00;
                                alu_op.shift          = 3'b001;

                                core_ctrl.rs1_alu_mux = 1'b0;
                                core_ctrl.rs2_alu_mux = 1'b0;                            
                            end 
                {2'b00,SRL} : begin 
                                alu_op.sub            = 1'b1;
                                alu_op.bitwise        = 2'b00;
                                alu_op.shift          = 3'b010;

                                core_ctrl.rs1_alu_mux = 1'b0;
                                core_ctrl.rs2_alu_mux = 1'b0;                            
                            end   
                {2'b01,SRA} : begin 
                                alu_op.sub            = 1'b1;
                                alu_op.bitwise        = 2'b00;
                                alu_op.shift          = 3'b011;

                                core_ctrl.rs1_alu_mux = 1'b0;
                                core_ctrl.rs2_alu_mux = 1'b0;                            
                            end     
                {2'b00,SLT} : begin 
                                alu_op.sub            = 1'b1;
                                alu_op.bitwise        = 2'b00;
                                alu_op.shift          = 3'b100;

                                core_ctrl.rs1_alu_mux = 1'b0;
                                core_ctrl.rs2_alu_mux = 1'b0;                            
                            end
                {2'b00,SLTU}: begin 
                                alu_op.sub            = 1'b1;
                                alu_op.bitwise        = 2'b00;
                                alu_op.shift          = 3'b101;

                                core_ctrl.rs1_alu_mux = 1'b0;
                                core_ctrl.rs2_alu_mux = 1'b0;                            
                            end
                {2'b00,XOR} :
                begin 
                                alu_op.sub            = 1'b1;
                                alu_op.bitwise        = 2'b00;
                                alu_op.shift          = 3'b000;

                                core_ctrl.rs1_alu_mux = 1'b0;
                                core_ctrl.rs2_alu_mux = 1'b0;                            
                            end
                {2'b00,AND} :begin 
                                alu_op.sub            = 1'b1;
                                alu_op.bitwise        = 2'b01;
                                alu_op.shift          = 3'b000;

                                core_ctrl.rs1_alu_mux = 1'b0;
                                core_ctrl.rs2_alu_mux = 1'b0;                            
                            end
                {2'b00,OR}  :begin 
                                alu_op.sub            = 1'b1;
                                alu_op.bitwise        = 2'b10;
                                alu_op.shift          = 3'b000;

                                core_ctrl.rs1_alu_mux = 1'b0;
                                core_ctrl.rs2_alu_mux = 1'b0;                            
                            end
              endcase
              OPCODE_ALU_I: begin
                unique case(itype_inst.funct3)
                    {2'b00,ADDI} : begin 
                        alu_op.sub            = 1'b0;
                        alu_op.bitwise        = 2'b00;
                        alu_op.shift          = 3'b000;

                        core_ctrl.rs1_alu_mux = 1'b0;
                        core_ctrl.rs2_alu_mux = 1'b1;
                        core_ctrl.imediate_alu_mux = 1'b1;

                      end 
                    {2'b00,SLTI} : begin 
                        alu_op.sub            = 1'b1;
                        alu_op.bitwise        = 2'b00;
                        alu_op.shift          = 3'b101;

                        core_ctrl.rs1_alu_mux = 1'b0;
                        core_ctrl.rs2_alu_mux = 1'b0;  
                        core_ctrl.imediate_alu_mux = 1'b1;

                      end
                      {2'b00,SLTUI} : begin 
                        alu_op.sub            = 1'b1;
                        alu_op.bitwise        = 2'b00;
                        alu_op.shift          = 3'b101;

                        core_ctrl.rs1_alu_mux = 1'b0;
                        core_ctrl.rs2_alu_mux = 1'b0;  
                        core_ctrl.imediate_alu_mux = 1'b1;

                      end  
                    endcase
                
            end

    endcase

          LUI: begin 
            operation             = LSU;
            core_ctrl.regselect   = REG_OPERAND2;
          end 

          AUIPC: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 

          JAL: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          JALR: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          BEQ: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          BNE: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          BLT: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          BGE: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          BLTU: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          BGEU: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          LB: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          LH: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          LW: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          LBU: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          LHU: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          SB: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          SH: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          SW: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          ADDI: begin 
            operation             = ADD;
            core_ctrl.regselect   = REG_OPERAND1;
          end 
          SLTI: begin 
            alu_op                = SLT;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          SLTIU: begin 
            alu_op                = SLTU;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          XORI: begin 
            alu_op                = XOR;
            core_ctrl.regselect   = REG_OPERAND1;
          end 
          ORI: begin 
            alu_op                = OR;
            core_ctrl.regselect   = REG_OPERAND1;
          end 
          ANDI: begin 
            alu_op                = AND;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          SLLI: begin 
            alu_op                = SLL;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          SRLI: begin 
            alu_op                = SRL;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          SRAI: begin 
            core_ctrl.operation   = SRA;
            core_ctrl.regselect   = REG_OPERAND2;
          end 

          ADD: begin 
            core_ctrl.operation   = ADD;
            core_ctrl.regselect   = REG_OPERAND2;
            
          end 
          SUB: begin 
            core_ctrl.operation   = SUB;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          SLL: begin 
            core_ctrl.operation   = SLL;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          SLT: begin 
            alu_op                = SLT;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          SLTU: begin 
            alu_op                = SLTU;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          SRL: begin 
            alu_op                = SRL;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          SRA: begin 
            alu_op                = SRA;
            core_ctrl.regselect   = REG_OPERAND2;
          end 

          OR: begin 
            alu_op                = OR;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          AND: begin 
            alu_op                = AND;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          FENCE: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          FENCEI: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          ECALL: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          EBREAK: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 
          ECALL: begin 
            alu_op                = ALU_OP_ADD;
            core_ctrl.regselect   = REG_OPERAND2;
          end 

*/