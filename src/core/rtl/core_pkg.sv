//  Package: core_pkg
//
package core_pkg;
    //  Group: Typedefs
    
/////////////
// Opcodes //
/////////////

    typedef enum logic [6:0] {
       U_TYPE           = 7'b??1_0111,
       J_TYPE           = 7'b110_?111,
       R_TYPE           = 7'b110_0111,
       S_TYPE           = 7'b010_0011,
       SB_TYPE          = 7'b001_0011,
       B_TYPE           = 7'b110_0011
    } inst_type_e;


    typedef enum logic [6:0] {
        STORE     = 7'b110_0111,
        LOAD             = 7'b010_0011,
        ALU_OP        = 7'b011_0011,
        ALU_OP_IMM    = 7'b001_0011
    } opcode_e;

    //  Instructions type
    typedef struct packed {
        logic [4:0] rs0_addr;
        logic [4:0] rs1_addr;
        logic [4:0] rd_addr;
    } regfile_op;
    
    typedef struct packed {
        logic [20:0] imm20_0;
        logic [4:0]  rd_addr;
        logic [6:0]  opcode;
    } Utype_inst_t;

    typedef struct packed {
        logic [20:0] imm20_0;
        logic [4:0]  rd_addr;
        logic [6:0]  opcode;
    } Jtype_inst_t;

    typedef struct packed {
        logic [6:0] funct7;
        logic [4:0] rs2_addr;
        logic [4:0] rs1_addr;
        logic [2:0] funct3;
        logic [6:0] imm4_0;
        logic [6:0] opcode;
    } Rtype_inst_t;

    typedef struct packed {
        logic [11:0] imm11_0;
        logic [4:0]  rs1_addr;
        logic [2:0]  funct3;
        logic [4:0]  rd_addr;
        logic [6:0]  opcode;
    } Itype_inst_t;

    typedef struct packed {
        logic [6:0]  imm11_0;
        logic [4:0]  shamt;
        logic [4:0]  rs1_addr;
        logic [2:0]  funct3;
        logic [4:0]  rd_addr;
        logic [6:0]  opcode;
    } SBtype_inst_t;

    typedef struct packed {
        logic [6:0] imm11_5;
        logic [4:0] rs2_addr;
        logic [4:0] rs1_addr;
        logic [2:0] funct3;
        logic [5:0] imm4_0;
        logic [6:0] opcode;
    } Stype_inst_t;

    typedef struct packed {
        logic [6:0] imm11_5;
        logic [4:0] rs2_addr;
        logic [4:0] rs1_addr;
        logic [2:0] funct3;
        logic [4:0] imm4_0;
        logic [6:0] opcode;
    } Btype_inst_t;
 

    //  alu controller
    typedef enum logic [2:0] {
        ADD_SUB  = 3'b000, // ADD or SUB 
        SLL  = 3'b001, // Shift logical rs1<<rs2 --> only 32bit shift;
        SLT  = 3'b010, // Set less than sign comparision if rs1<rs2? -> 0 | 1
        SLTU = 3'b011, // unsigned set less than  
        XOR  = 3'b100, // logical operation  rs1^rs2
        SRL_SRA  = 3'b101, // rs1>>>rs2 adding zero MSB
        OR   = 3'b110, // 
        AND  = 3'b111
    } alu_op_t;
    
    //  load controller
    typedef enum logic [2:0] {
        ld_LB  = 3'b000,
        ld_LH  = 3'b001,
        ld_LW  = 3'b010,
        ld_LD  = 3'b011,
        ld_LBU = 3'b100,
        ld_LHU = 3'b101,
        ld_LWU = 3'b110
    } ld_op_t;
    
    //  store controller
    typedef enum logic [2:0] {
        SB  = 3'b000,
        SH  = 3'b001,
        LW  = 3'b010,
        LD  = 3'b011
    } sd_op_t;
    
    //  branch controller
    typedef enum logic [2:0] {
        BEQ  = 3'b000, 
        BNE  = 3'b001, 
        BLT  = 3'b100,
        BGE  = 3'b101,
        BLTU = 3'b110,   
        BGEU = 3'b111
    } branch_op_t;

    localparam int unsigned ALU_OP_BITS = 3;
    localparam int unsigned OP_BITS = 4;

    typedef enum logic [1:0]{
        IMEM,
        REG_OPERAND,
        BYPASS
    } operand_sel_t;

    typedef struct packed {
        logic [4:0] rs1_addr;
        logic [4:0] rs2_addr;
        logic [4:0] rd_addr;
    } reg_addr_t;

    typedef struct packed {
        operand_sel_t  op_mux_sel_0;
        operand_sel_t  op_mux_sel_1;
        alu_op_t       alu_op;
        ld_op_t        load_op;
        sd_op_t        store_op;   
        logic          invert;
        reg_addr_t     addr;
        logic [31:0]   sign_extended;
        inst_type_e    inst_t;
    } core_ctrl_t;


endpackage: core_pkg
