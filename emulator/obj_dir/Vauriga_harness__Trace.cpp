// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_fst_c.h"
#include "Vauriga_harness__Syms.h"


void Vauriga_harness::traceChgTop0(void* userp, VerilatedFst* tracep) {
    Vauriga_harness__Syms* __restrict vlSymsp = static_cast<Vauriga_harness__Syms*>(userp);
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    {
        vlTOPp->traceChgSub0(userp, tracep);
    }
}

void Vauriga_harness::traceChgSub0(void* userp, VerilatedFst* tracep) {
    Vauriga_harness__Syms* __restrict vlSymsp = static_cast<Vauriga_harness__Syms*>(userp);
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    const vluint32_t base = vlSymsp->__Vm_baseCode + 1;
    if (false && tracep && base) {}  // Prevent unused
    // Body
    {
        if (VL_UNLIKELY(vlTOPp->__Vm_traceActivity[1U])) {
            tracep->chgIData(base+0,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[0]),32);
            tracep->chgIData(base+1,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[1]),32);
            tracep->chgIData(base+2,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[2]),32);
            tracep->chgIData(base+3,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[3]),32);
            tracep->chgIData(base+4,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[4]),32);
            tracep->chgIData(base+5,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[5]),32);
            tracep->chgIData(base+6,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[6]),32);
            tracep->chgIData(base+7,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[7]),32);
            tracep->chgIData(base+8,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[8]),32);
            tracep->chgIData(base+9,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[9]),32);
            tracep->chgIData(base+10,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[10]),32);
            tracep->chgIData(base+11,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[11]),32);
            tracep->chgIData(base+12,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[12]),32);
            tracep->chgIData(base+13,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[13]),32);
            tracep->chgIData(base+14,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[14]),32);
            tracep->chgIData(base+15,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[15]),32);
            tracep->chgIData(base+16,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[16]),32);
            tracep->chgIData(base+17,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[17]),32);
            tracep->chgIData(base+18,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[18]),32);
            tracep->chgIData(base+19,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[19]),32);
            tracep->chgIData(base+20,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[20]),32);
            tracep->chgIData(base+21,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[21]),32);
            tracep->chgIData(base+22,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[22]),32);
            tracep->chgIData(base+23,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[23]),32);
            tracep->chgIData(base+24,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[24]),32);
            tracep->chgIData(base+25,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[25]),32);
            tracep->chgIData(base+26,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[26]),32);
            tracep->chgIData(base+27,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[27]),32);
            tracep->chgIData(base+28,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[28]),32);
            tracep->chgIData(base+29,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[29]),32);
            tracep->chgIData(base+30,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[30]),32);
            tracep->chgIData(base+31,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[31]),32);
        }
        tracep->chgBit(base+32,(vlTOPp->clk_i));
        tracep->chgBit(base+33,(vlTOPp->rst_n_i));
        tracep->chgBit(base+34,(vlTOPp->rs0_re_i));
        tracep->chgCData(base+35,(vlTOPp->rs0_addr_i),5);
        tracep->chgIData(base+36,(vlTOPp->rs0_data_i),32);
        tracep->chgBit(base+37,(vlTOPp->rs1_re_i));
        tracep->chgCData(base+38,(vlTOPp->rs1_addr_i),5);
        tracep->chgIData(base+39,(vlTOPp->rs1_data_i),32);
        tracep->chgBit(base+40,(vlTOPp->rd_we_i));
        tracep->chgCData(base+41,(vlTOPp->rd_addr_i),5);
        tracep->chgIData(base+42,(vlTOPp->rd_data_i),32);
    }
}

void Vauriga_harness::traceCleanup(void* userp, VerilatedFst* /*unused*/) {
    Vauriga_harness__Syms* __restrict vlSymsp = static_cast<Vauriga_harness__Syms*>(userp);
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlSymsp->__Vm_activity = false;
        vlTOPp->__Vm_traceActivity[0U] = 0U;
        vlTOPp->__Vm_traceActivity[1U] = 0U;
    }
}
