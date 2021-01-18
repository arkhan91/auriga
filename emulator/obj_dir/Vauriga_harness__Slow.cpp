// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vauriga_harness.h for the primary calling header

#include "Vauriga_harness.h"
#include "Vauriga_harness__Syms.h"

//==========

VL_CTOR_IMP(Vauriga_harness), __Vm_mt_13(2), __Vm_mt_final(3), 
  __Vm_threadPoolp(NULL), __Vm_even_cycle(false) {
    Vauriga_harness__Syms* __restrict vlSymsp = __VlSymsp = new Vauriga_harness__Syms(this, name());
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    _ctor_var_reset();
    __Vm_threadPoolp = new VlThreadPool(11, 0);
}

void Vauriga_harness::__Vconfigure(Vauriga_harness__Syms* vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
    if (false && this->__VlSymsp) {}  // Prevent unused
    Verilated::timeunit(-12);
    Verilated::timeprecision(-12);
}

Vauriga_harness::~Vauriga_harness() {
    VL_DO_CLEAR(delete __Vm_threadPoolp, __Vm_threadPoolp = NULL);
    VL_DO_CLEAR(delete __VlSymsp, __VlSymsp = NULL);
}

void Vauriga_harness::_eval_initial(Vauriga_harness__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vauriga_harness::_eval_initial\n"); );
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->__Vclklast__TOP__clk_i = vlTOPp->clk_i;
}

void Vauriga_harness::final() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vauriga_harness::final\n"); );
    // Variables
    Vauriga_harness__Syms* __restrict vlSymsp = this->__VlSymsp;
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Vauriga_harness::_eval_settle(Vauriga_harness__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vauriga_harness::_eval_settle\n"); );
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Vauriga_harness::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vauriga_harness::_ctor_var_reset\n"); );
    // Body
    clk_i = VL_RAND_RESET_I(1);
    rst_n_i = VL_RAND_RESET_I(1);
    rs0_re_i = VL_RAND_RESET_I(1);
    rs0_addr_i = VL_RAND_RESET_I(5);
    rs0_data_i = VL_RAND_RESET_I(32);
    rs1_re_i = VL_RAND_RESET_I(1);
    rs1_addr_i = VL_RAND_RESET_I(5);
    rs1_data_i = VL_RAND_RESET_I(32);
    rd_we_i = VL_RAND_RESET_I(1);
    rd_addr_i = VL_RAND_RESET_I(5);
    rd_data_i = VL_RAND_RESET_I(32);
    { int __Vi0=0; for (; __Vi0<32; ++__Vi0) {
            auriga_harness__DOT__u_core_regfile__DOT__regfile[__Vi0] = VL_RAND_RESET_I(32);
    }}
    __Vdlyvdim0__auriga_harness__DOT__u_core_regfile__DOT__regfile__v0 = 0;
    __Vdlyvval__auriga_harness__DOT__u_core_regfile__DOT__regfile__v0 = VL_RAND_RESET_I(32);
    __Vdlyvset__auriga_harness__DOT__u_core_regfile__DOT__regfile__v0 = 0;
    { int __Vi0=0; for (; __Vi0<2; ++__Vi0) {
            __Vm_traceActivity[__Vi0] = VL_RAND_RESET_I(1);
    }}
}
