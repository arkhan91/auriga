
VERILATOR = verilator
GTKWAVE = gtkwave
VERILATOR_ROOT ?= $(shell bash -c 'verilator -V|grep VERILATOR_ROOT | head -1 | sed -e "s/^.*=\s*//"')

RTLDIR 	= ../src
SRCDIR 	= src
INCDIR 	= include


THREADS = 1

# -O3 gives fastest simulator but takes _veeery_ long for compiling
OPTLVL  = 

OPTASS  = 
#~ OPTASS  = --assert

CFLAGS 	= $(OPTLVL) -std=c++11 -DVL_DEBUG -I../$(INCDIR) -lm
LDFLAGS	=	'-lpthread'

VDEFS		=	+define+SIMULATION

# Tracing Settings ##############################################

# set TRACE_TYPE to FST for generating FST traces or to anything else for VCD.
# FST can be processed much faster by Gtkwave and has many advantages (e.g. symbolic state names in FSM),
# but can be interpreted my Gtkwave only.
TRACE_TYPE = FST

ifeq ($(TRACE_TYPE),FST)
	TRACE_OPTS = --trace-fst --trace-structs
	CFLAGS += -DTRACE_FST
	TRACEFILE = trace.fst
else
	TRACE_OPTS = --trace
	TRACEFILE = trace.vcd
endif

TRACE_OPTS += --no-trace-params --trace-structs 

# Uncommment the following for tracing TCDM or IMEM memory array contents. This will slowdown simulation.
# TRACE_OPTS += --trace-max-array 32768

# single threaded
#VOPTS		= --trace -Wno-lint -Wno-UNPACKED -Wno-UNOPTFLAT  -Wno-SHORTREAL --clk harness.clk_i 

# multithreaded
VOPTS		= --threads $(THREADS) $(TRACE_OPTS) -Wno-lint -Wno-UNPACKED -Wno-UNOPTFLAT -Wno-UNOPTTHREADS  -Wno-SHORTREAL --clk harness.clk_i 

VINCS		= 

TOPLEVEL = auriga_harness
TB_NAME  = auriga


# Save file for GTKwave containing wave set for displaying
WAVESDIR	=	waves
#~ GTKSAVEFILE = sag_wave.gtkw
#~ GTKSAVEFILE = loopgen.gtkw
#~ GTKSAVEFILE = au_test.gtkw
#~ GTKSAVEFILE = fifos.gtkw

# All C++ source file
CFILES	=		$(SRCDIR)/$(TB_NAME).cpp

# All (System-)Verilog source files
VFILES	=	$(RTLDIR)/core/rtl/core_pkg.sv \
			$(RTLDIR)/core/rtl/core_regfile.sv \
			$(RTLDIR)/core/rtl/alu.sv \
			$(RTLDIR)/core/rtl/core_decoder.sv \
			$(RTLDIR)/core/rtl/core_execution.sv \
			$(RTLDIR)/core/rtl/core_fetch.sv \
			$(RTLDIR)/core/rtl/core_writeback.sv \
			$(RTLDIR)/core/rtl/core.sv \
			harness.sv

all: build run

help: 
	@echo "make compile"

compile_rtl:  $(VFILES) $(CFILES)
	@echo "\nCompiling..."
	@echo $(CFLAGS)
	$(VERILATOR)  $(OPTASS) $(VOPTS) $(VINCS) -CFLAGS '$(CFLAGS)' -LDFLAGS $(LDFLAGS) $(VDEFS) --top-module $(TOPLEVEL) $(VFILES) --cc --exe $(CFILES) -o V$(TB_NAME)

# compile verilog into C++
compile: $(VFILES) $(CFILES)
	@echo "\nCompiling..."
	@echo $(CFLAGS)
	$(VERILATOR)  $(OPTASS) $(VOPTS) $(VINCS) -CFLAGS '$(CFLAGS)' -LDFLAGS $(LDFLAGS) $(VDEFS) --top-module $(TOPLEVEL) $(VFILES) --cc --exe $(CFILES) -o V$(TB_NAME)
	
# compile C++ model into executable
build: compile
	@echo "\nBuilding..............."
	make  --no-print-directory -C obj_dir -f V$(TOPLEVEL).mk
	mv obj_dir/V$(TB_NAME) .
			
# execute simulation
run: V$(TB_NAME)
	@echo "Executing model.................."
	./V$(TB_NAME)
	@echo "Done."
	
# start gtkwave to show vcd waveform dump
wave: $(TRACEFILE)
	$(GTKWAVE) $(TRACEFILE) -a $(WAVESDIR)/$(GTKSAVEFILE) &

# cleanup	
clean:
	rm -rf obj_dir
	rm -f V$(TB_NAME)
	rm -f trace.vcd trace.fst
