// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vauriga_harness.h for the primary calling header

#include "Vauriga_harness.h"
#include "Vauriga_harness__Syms.h"

//==========

void Vauriga_harness::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vauriga_harness::eval\n"); );
    Vauriga_harness__Syms* __restrict vlSymsp = this->__VlSymsp;  // Setup global symbol table
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
#ifdef VL_DEBUG
    // Debug assertions
    _eval_debug_assertions();
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        vlSymsp->__Vm_activity = true;
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("harness.sv", 1, "",
                "Verilated model didn't converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

void Vauriga_harness::_eval_initial_loop(Vauriga_harness__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    _eval_initial(vlSymsp);
    vlSymsp->__Vm_activity = true;
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        _eval_settle(vlSymsp);
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("harness.sv", 1, "",
                "Verilated model didn't DC converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
}

VL_INLINE_OPT void Vauriga_harness::_sequent__TOP__7(Vauriga_harness__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vauriga_harness::_sequent__TOP__7\n"); );
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->__Vdlyvset__auriga_harness__DOT__u_core_regfile__DOT__regfile__v0 = 0U;
}

VL_INLINE_OPT void Vauriga_harness::_sequent__TOP__8(Vauriga_harness__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vauriga_harness::_sequent__TOP__8\n"); );
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if (vlTOPp->rs0_re_i) {
        vlTOPp->rs0_data_i = vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile
            [vlTOPp->rs0_addr_i];
    }
}

VL_INLINE_OPT void Vauriga_harness::_sequent__TOP__9(Vauriga_harness__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vauriga_harness::_sequent__TOP__9\n"); );
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if (vlTOPp->rs1_re_i) {
        vlTOPp->rs1_data_i = vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile
            [vlTOPp->rs1_addr_i];
    }
}

VL_INLINE_OPT void Vauriga_harness::_sequent__TOP__10(Vauriga_harness__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vauriga_harness::_sequent__TOP__10\n"); );
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if (vlTOPp->rd_we_i) {
        vlTOPp->__Vdlyvval__auriga_harness__DOT__u_core_regfile__DOT__regfile__v0 
            = vlTOPp->rd_data_i;
        vlTOPp->__Vdlyvset__auriga_harness__DOT__u_core_regfile__DOT__regfile__v0 = 1U;
        vlTOPp->__Vdlyvdim0__auriga_harness__DOT__u_core_regfile__DOT__regfile__v0 
            = vlTOPp->rd_addr_i;
    }
}

VL_INLINE_OPT void Vauriga_harness::_sequent__TOP__13(Vauriga_harness__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vauriga_harness::_sequent__TOP__13\n"); );
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if (vlTOPp->__Vdlyvset__auriga_harness__DOT__u_core_regfile__DOT__regfile__v0) {
        vlTOPp->auriga_harness__DOT__u_core_regfile__DOT__regfile[vlTOPp->__Vdlyvdim0__auriga_harness__DOT__u_core_regfile__DOT__regfile__v0] 
            = vlTOPp->__Vdlyvval__auriga_harness__DOT__u_core_regfile__DOT__regfile__v0;
    }
}

void Vauriga_harness::_eval(Vauriga_harness__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vauriga_harness::_eval\n"); );
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->__Vm_even_cycle = !vlTOPp->__Vm_even_cycle;
    vlTOPp->__Vm_threadPoolp->workerp(0)->addTask(__Vmtask__7, vlTOPp->__Vm_even_cycle, vlSymsp);
    vlTOPp->__Vm_threadPoolp->workerp(1)->addTask(__Vmtask__8, vlTOPp->__Vm_even_cycle, vlSymsp);
    __Vmtask__9(vlTOPp->__Vm_even_cycle, vlSymsp);
    Verilated::mtaskId(0);
    vlTOPp->__Vm_mt_final.waitUntilUpstreamDone(vlTOPp->__Vm_even_cycle);
    // Final
    vlTOPp->__Vclklast__TOP__clk_i = vlTOPp->clk_i;
}

VL_INLINE_OPT QData Vauriga_harness::_change_request(Vauriga_harness__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vauriga_harness::_change_request\n"); );
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    return (vlTOPp->_change_request_1(vlSymsp));
}

VL_INLINE_OPT QData Vauriga_harness::_change_request_1(Vauriga_harness__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vauriga_harness::_change_request_1\n"); );
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void Vauriga_harness::_eval_debug_assertions() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vauriga_harness::_eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((clk_i & 0xfeU))) {
        Verilated::overWidthError("clk_i");}
    if (VL_UNLIKELY((rst_n_i & 0xfeU))) {
        Verilated::overWidthError("rst_n_i");}
    if (VL_UNLIKELY((rs0_re_i & 0xfeU))) {
        Verilated::overWidthError("rs0_re_i");}
    if (VL_UNLIKELY((rs0_addr_i & 0xe0U))) {
        Verilated::overWidthError("rs0_addr_i");}
    if (VL_UNLIKELY((rs1_re_i & 0xfeU))) {
        Verilated::overWidthError("rs1_re_i");}
    if (VL_UNLIKELY((rs1_addr_i & 0xe0U))) {
        Verilated::overWidthError("rs1_addr_i");}
    if (VL_UNLIKELY((rd_we_i & 0xfeU))) {
        Verilated::overWidthError("rd_we_i");}
    if (VL_UNLIKELY((rd_addr_i & 0xe0U))) {
        Verilated::overWidthError("rd_addr_i");}
}
#endif  // VL_DEBUG

void Vauriga_harness::__Vmtask__7(bool even_cycle, void* symtab) {
    Vauriga_harness__Syms* __restrict vlSymsp = (Vauriga_harness__Syms*)symtab;
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    Verilated::mtaskId(7);
    if (((IData)(vlTOPp->clk_i) & (~ (IData)(vlTOPp->__Vclklast__TOP__clk_i)))) {
        vlTOPp->_sequent__TOP__7(vlSymsp);
    }
    Verilated::endOfThreadMTask(vlSymsp->__Vm_evalMsgQp);
    Verilated::mtaskId(10);
    if (((IData)(vlTOPp->clk_i) & (~ (IData)(vlTOPp->__Vclklast__TOP__clk_i)))) {
        vlTOPp->_sequent__TOP__10(vlSymsp);
    }
    Verilated::endOfThreadMTask(vlSymsp->__Vm_evalMsgQp);
    vlTOPp->__Vm_mt_13.waitUntilUpstreamDone(even_cycle);
    Verilated::mtaskId(13);
    if (((IData)(vlTOPp->clk_i) & (~ (IData)(vlTOPp->__Vclklast__TOP__clk_i)))) {
        vlTOPp->_sequent__TOP__13(vlSymsp);
        vlTOPp->__Vm_traceActivity[1U] = 1U;
    }
    Verilated::endOfThreadMTask(vlSymsp->__Vm_evalMsgQp);
    vlTOPp->__Vm_mt_final.signalUpstreamDone(even_cycle);
}

void Vauriga_harness::__Vmtask__8(bool even_cycle, void* symtab) {
    Vauriga_harness__Syms* __restrict vlSymsp = (Vauriga_harness__Syms*)symtab;
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    Verilated::mtaskId(8);
    if (((IData)(vlTOPp->clk_i) & (~ (IData)(vlTOPp->__Vclklast__TOP__clk_i)))) {
        vlTOPp->_sequent__TOP__8(vlSymsp);
    }
    Verilated::endOfThreadMTask(vlSymsp->__Vm_evalMsgQp);
    vlTOPp->__Vm_mt_13.signalUpstreamDone(even_cycle);
    vlTOPp->__Vm_mt_final.signalUpstreamDone(even_cycle);
}

void Vauriga_harness::__Vmtask__9(bool even_cycle, void* symtab) {
    Vauriga_harness__Syms* __restrict vlSymsp = (Vauriga_harness__Syms*)symtab;
    Vauriga_harness* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    Verilated::mtaskId(9);
    if (((IData)(vlTOPp->clk_i) & (~ (IData)(vlTOPp->__Vclklast__TOP__clk_i)))) {
        vlTOPp->_sequent__TOP__9(vlSymsp);
    }
    Verilated::endOfThreadMTask(vlSymsp->__Vm_evalMsgQp);
    vlTOPp->__Vm_mt_13.signalUpstreamDone(even_cycle);
    vlTOPp->__Vm_mt_final.signalUpstreamDone(even_cycle);
}
