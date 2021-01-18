// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _VAURIGA_HARNESS_H_
#define _VAURIGA_HARNESS_H_  // guard

#include "verilated.h"
#include "verilated_threads.h"

//==========

class Vauriga_harness__Syms;
class Vauriga_harness_VerilatedFst;


//----------

VL_MODULE(Vauriga_harness) {
  public:
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    // Begin mtask footprint all: 1 2 3 4 
    VL_IN8(clk_i,0,0);
    // Begin mtask footprint all: 10 
    VL_IN(rd_data_i,31,0);
    VL_IN8(rd_we_i,0,0);
    VL_IN8(rd_addr_i,4,0);
    // Begin mtask footprint all: 5 11 
    VL_OUT(rs1_data_i,31,0);
    // Begin mtask footprint all: 8 
    VL_IN8(rs0_re_i,0,0);
    VL_IN8(rs0_addr_i,4,0);
    // Begin mtask footprint all: 9 
    VL_IN8(rs1_re_i,0,0);
    VL_IN8(rs1_addr_i,4,0);
    // Begin mtask footprint all: 
    VL_IN8(rst_n_i,0,0);
    // Begin mtask footprint all: 6 12 
    VL_OUT(rs0_data_i,31,0);
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    // Begin mtask footprint all: 8 9 13 
    IData/*31:0*/ auriga_harness__DOT__u_core_regfile__DOT__regfile[32];
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    // Begin mtask footprint all: 
    CData/*0:0*/ __Vm_traceActivity[2];
    CData/*0:0*/ __Vclklast__TOP__clk_i;
    // Begin mtask footprint all: 10 13 
    IData/*31:0*/ __Vdlyvval__auriga_harness__DOT__u_core_regfile__DOT__regfile__v0;
    CData/*4:0*/ __Vdlyvdim0__auriga_harness__DOT__u_core_regfile__DOT__regfile__v0;
    // Begin mtask footprint all: 7 10 13 
    CData/*0:0*/ __Vdlyvset__auriga_harness__DOT__u_core_regfile__DOT__regfile__v0;
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    Vauriga_harness__Syms* __VlSymsp;  // Symbol table
  private:
    VlMTaskVertex __Vm_mt_13;
    VlMTaskVertex __Vm_mt_final;
    VlThreadPool* __Vm_threadPoolp;
    bool __Vm_even_cycle;
  public:
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vauriga_harness);  ///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// The special name  may be used to make a wrapper with a
    /// single model invisible with respect to DPI scope names.
    Vauriga_harness(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    ~Vauriga_harness();
    /// Trace signals in the model; called by application code
    void trace(VerilatedFstC* tfp, int levels, int options = 0);
    
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval() { eval_step(); }
    /// Evaluate when calling multiple units/models per time step.
    void eval_step();
    /// Evaluate at end of a timestep for tracing, when using eval_step().
    /// Application must call after all eval() and before time changes.
    void eval_end_step() {}
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    
    // INTERNAL METHODS
  private:
    static void _eval_initial_loop(Vauriga_harness__Syms* __restrict vlSymsp);
  public:
    void __Vconfigure(Vauriga_harness__Syms* symsp, bool first);
  private:
    static QData _change_request(Vauriga_harness__Syms* __restrict vlSymsp);
    static QData _change_request_1(Vauriga_harness__Syms* __restrict vlSymsp);
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    static void _eval(Vauriga_harness__Syms* __restrict vlSymsp);
  private:
#ifdef VL_DEBUG
    void _eval_debug_assertions();
#endif  // VL_DEBUG
  public:
    static void _eval_initial(Vauriga_harness__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _eval_settle(Vauriga_harness__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _sequent__TOP__10(Vauriga_harness__Syms* __restrict vlSymsp);
    static void _sequent__TOP__13(Vauriga_harness__Syms* __restrict vlSymsp);
    static void _sequent__TOP__7(Vauriga_harness__Syms* __restrict vlSymsp);
    static void _sequent__TOP__8(Vauriga_harness__Syms* __restrict vlSymsp);
    static void _sequent__TOP__9(Vauriga_harness__Syms* __restrict vlSymsp);
  private:
    static void traceChgSub0(void* userp, VerilatedFst* tracep);
    static void traceChgTop0(void* userp, VerilatedFst* tracep);
    static void traceCleanup(void* userp, VerilatedFst* /*unused*/);
    static void traceFullSub0(void* userp, VerilatedFst* tracep) VL_ATTR_COLD;
    static void traceFullTop0(void* userp, VerilatedFst* tracep) VL_ATTR_COLD;
    static void traceInitSub0(void* userp, VerilatedFst* tracep) VL_ATTR_COLD;
    static void traceInitTop(void* userp, VerilatedFst* tracep) VL_ATTR_COLD;
    void traceRegister(VerilatedFst* tracep) VL_ATTR_COLD;
    static void __Vmtask__7(bool even_cycle, void* symtab);
    static void __Vmtask__8(bool even_cycle, void* symtab);
    static void __Vmtask__9(bool even_cycle, void* symtab);
    static void __Vmtask__final(bool even_cycle, void* symtab);
    static void traceInit(void* userp, VerilatedFst* tracep, uint32_t code) VL_ATTR_COLD;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
