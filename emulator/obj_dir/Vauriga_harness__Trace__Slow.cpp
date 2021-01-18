// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_fst_c.h"
#include "Vauriga_harness__Syms.h"


//======================

void Vauriga_harness::trace(VerilatedFstC* tfp, int, int) {
    tfp->spTrace()->addInitCb(&traceInit, __VlSymsp);
    traceRegister(tfp->spTrace());
}

void Vauriga_harness::traceInit(void* userp, VerilatedFst* tracep, uint32_t code) {
    // Callback from tracep->open()
    Vauriga_harness__Syms* __restrict vlSymsp = static_cast<Vauriga_harness__Syms*>(userp);
    if (!Verilated::calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
                        "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->module(vlSymsp->name());
    tracep->scopeEscape(' ');
    Vauriga_harness::traceInitTop(vlSymsp, tracep);
    tracep->scopeEscape('.');
}

//======================


void Vauriga_harness::traceInitTop(void* userp, VerilatedFst* tracep) {
    Vauriga_harness__Syms* __restrict vlSymsp = static_cast<Vauriga_harness__Syms*>(userp);
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlTOPp->traceInitSub0(userp, tracep);
    }
}

void Vauriga_harness::traceInitSub0(void* userp, VerilatedFst* tracep) {
    Vauriga_harness__Syms* __restrict vlSymsp = static_cast<Vauriga_harness__Syms*>(userp);
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    const int c = vlSymsp->__Vm_baseCode;
    if (false && tracep && c) {}  // Prevent unused
    // Body
    {
        tracep->declBit(c+33,"clk_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBit(c+34,"rst_n_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBit(c+35,"rs0_re_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBus(c+36,"rs0_addr_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
        tracep->declBus(c+37,"rs0_data_i",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
        tracep->declBit(c+38,"rs1_re_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBus(c+39,"rs1_addr_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
        tracep->declBus(c+40,"rs1_data_i",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
        tracep->declBit(c+41,"rd_we_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBus(c+42,"rd_addr_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
        tracep->declBus(c+43,"rd_data_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
        tracep->declBit(c+33,"auriga_harness clk_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBit(c+34,"auriga_harness rst_n_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBit(c+35,"auriga_harness rs0_re_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBus(c+36,"auriga_harness rs0_addr_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
        tracep->declBus(c+37,"auriga_harness rs0_data_i",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
        tracep->declBit(c+38,"auriga_harness rs1_re_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBus(c+39,"auriga_harness rs1_addr_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
        tracep->declBus(c+40,"auriga_harness rs1_data_i",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
        tracep->declBit(c+41,"auriga_harness rd_we_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBus(c+42,"auriga_harness rd_addr_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
        tracep->declBus(c+43,"auriga_harness rd_data_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
        tracep->declBit(c+33,"auriga_harness u_core_regfile clk_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBit(c+34,"auriga_harness u_core_regfile rst_n_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBit(c+35,"auriga_harness u_core_regfile rs0_re_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBus(c+36,"auriga_harness u_core_regfile rs0_addr_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
        tracep->declBus(c+37,"auriga_harness u_core_regfile rs0_data_i",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
        tracep->declBit(c+38,"auriga_harness u_core_regfile rs1_re_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBus(c+39,"auriga_harness u_core_regfile rs1_addr_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
        tracep->declBus(c+40,"auriga_harness u_core_regfile rs1_data_i",-1,FST_VD_OUTPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
        tracep->declBit(c+41,"auriga_harness u_core_regfile rd_we_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1);
        tracep->declBus(c+42,"auriga_harness u_core_regfile rd_addr_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 4,0);
        tracep->declBus(c+43,"auriga_harness u_core_regfile rd_data_i",-1,FST_VD_INPUT,FST_VT_VCD_WIRE, false,-1, 31,0);
        {int i; for (i=0; i<32; i++) {
                tracep->declBus(c+1+i*1,"auriga_harness u_core_regfile regfile",-1, FST_VD_IMPLICIT,FST_VT_SV_LOGIC, true,(i+0), 31,0);}}
    }
}

void Vauriga_harness::traceRegister(VerilatedFst* tracep) {
    // Body
    {
        tracep->addFullCb(&traceFullTop0, __VlSymsp);
        tracep->addChgCb(&traceChgTop0, __VlSymsp);
        tracep->addCleanupCb(&traceCleanup, __VlSymsp);
    }
}

void Vauriga_harness::traceFullTop0(void* userp, VerilatedFst* tracep) {
    Vauriga_harness__Syms* __restrict vlSymsp = static_cast<Vauriga_harness__Syms*>(userp);
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlTOPp->traceFullSub0(userp, tracep);
    }
}

void Vauriga_harness::traceFullSub0(void* userp, VerilatedFst* tracep) {
    Vauriga_harness__Syms* __restrict vlSymsp = static_cast<Vauriga_harness__Syms*>(userp);
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        tracep->fullIData(oldp+1,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[0]),32);
        tracep->fullIData(oldp+2,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[1]),32);
        tracep->fullIData(oldp+3,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[2]),32);
        tracep->fullIData(oldp+4,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[3]),32);
        tracep->fullIData(oldp+5,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[4]),32);
        tracep->fullIData(oldp+6,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[5]),32);
        tracep->fullIData(oldp+7,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[6]),32);
        tracep->fullIData(oldp+8,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[7]),32);
        tracep->fullIData(oldp+9,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[8]),32);
        tracep->fullIData(oldp+10,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[9]),32);
        tracep->fullIData(oldp+11,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[10]),32);
        tracep->fullIData(oldp+12,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[11]),32);
        tracep->fullIData(oldp+13,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[12]),32);
        tracep->fullIData(oldp+14,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[13]),32);
        tracep->fullIData(oldp+15,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[14]),32);
        tracep->fullIData(oldp+16,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[15]),32);
        tracep->fullIData(oldp+17,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[16]),32);
        tracep->fullIData(oldp+18,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[17]),32);
        tracep->fullIData(oldp+19,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[18]),32);
        tracep->fullIData(oldp+20,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[19]),32);
        tracep->fullIData(oldp+21,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[20]),32);
        tracep->fullIData(oldp+22,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[21]),32);
        tracep->fullIData(oldp+23,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[22]),32);
        tracep->fullIData(oldp+24,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[23]),32);
        tracep->fullIData(oldp+25,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[24]),32);
        tracep->fullIData(oldp+26,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[25]),32);
        tracep->fullIData(oldp+27,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[26]),32);
        tracep->fullIData(oldp+28,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[27]),32);
        tracep->fullIData(oldp+29,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[28]),32);
        tracep->fullIData(oldp+30,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[29]),32);
        tracep->fullIData(oldp+31,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[30]),32);
        tracep->fullIData(oldp+32,(vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[31]),32);
        tracep->fullBit(oldp+33,(vlTOPp->clk_i));
        tracep->fullBit(oldp+34,(vlTOPp->rst_n_i));
        tracep->fullBit(oldp+35,(vlTOPp->rs0_re_i));
        tracep->fullCData(oldp+36,(vlTOPp->rs0_addr_i),5);
        tracep->fullIData(oldp+37,(vlTOPp->rs0_data_i),32);
        tracep->fullBit(oldp+38,(vlTOPp->rs1_re_i));
        tracep->fullCData(oldp+39,(vlTOPp->rs1_addr_i),5);
        tracep->fullIData(oldp+40,(vlTOPp->rs1_data_i),32);
        tracep->fullBit(oldp+41,(vlTOPp->rd_we_i));
        tracep->fullCData(oldp+42,(vlTOPp->rd_addr_i),5);
        tracep->fullIData(oldp+43,(vlTOPp->rd_data_i),32);
    }
}
