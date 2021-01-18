#include <atomic>
#include <thread>
#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <math.h>
#include "Vauriga_harness.h"
#include "verilated.h"

#ifdef TRACE_FST

// generate FST trace files
#include "verilated_fst_c.h"
#define   TRACETYPE VerilatedFstC
#define   TRACEFILE "trace.fst"  

#else

// generate VCD trace files
#include "verilated_vcd_c.h"
#define   TRACETYPE VerilatedVcdC
#define   TRACEFILE "trace.vcd"  

#endif


uint32_t T=1;




void tick (uint32_t* T,Vauriga_harness *auriga, TRACETYPE* tfp, int Tsteps) {

  for (int Tlocal=0; Tlocal<Tsteps;Tlocal++) {
    auriga-> eval();
    if (tfp) tfp->dump((*T)*10-1);
    
    auriga->clk_i = 1;
    auriga-> eval();
    if (tfp) tfp->dump((*T)*10);

   
    auriga->clk_i = 0;
    auriga-> eval();
    
     
		if (tfp) {
			tfp->dump((*T)*10+5);
			tfp->flush();
		}
    (*T)++;
  }
}
void init_states (uint32_t* T, Vauriga_harness *auriga, TRACETYPE* tfp)
{
		auriga->clk_i   = 0;
    
    auriga->rst_n_i = 1;
    tick (T, auriga, tfp, 10);  
} // init_states()

void gen_reset (uint32_t* T, Vauriga_harness *auriga, TRACETYPE* tfp, int w)
{
   tick (T, auriga, tfp, 1);
   auriga->rst_n_i = 0;


   tick (T, auriga, tfp, w);
   auriga->rst_n_i = 1; 
} // gen_reset()

int main (int argc, char **argv)
{
	Verilated::commandArgs(argc, argv);
	Verilated::traceEverOn(true);
  Verilated::assertOn(false);
	
	Vauriga_harness *auriga = new Vauriga_harness();
	TRACETYPE *tfp = new TRACETYPE();
	
	auriga->trace(tfp,99); //level of hierarchy
	tfp->open(TRACEFILE); // tracefile
	
  init_states (&T, auriga, tfp);
  tick(&T,auriga,tfp,5);
  gen_reset (&T, auriga, tfp, 3);

  
  Verilated::assertOn(true);
  tick(&T,auriga,tfp,10);

  tfp->close();
	delete auriga;
}