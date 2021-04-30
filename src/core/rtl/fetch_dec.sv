
// LISCENCE
module fetch_dec();
    

    regfile #(
        .FEATURES(RV32I),
        .IMPLMNT(DEFUALT)
    ) u_regfile(
        .clk_i(clk_i),
        .arst_ni(arst_ni),
        // READ PORTS
        .roperands_o(rg_roperands),
        .raddr_i(id_raddr),
        .ren_i(id_ren),

        // WRITE PORTS
        .woperands_i(wb_woperands),
        .waddr_i(wb_waddr),
        .wen_i(wb_wen)
);

controller();
endmodule : fetch_dec