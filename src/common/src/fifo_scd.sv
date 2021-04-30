// LICENSE
/*
FIRST in FIRST OUT.
SAME CLK DOMAIN
*/

module fifo_scd  #(
    parameter int unsigned WIDTH = 32,
    parameter int unsigned DEPTH = 16
)(
    input logic clk_i,
    input logic arst_ni,
    input logic ren_i,
    input logic wen_i,
    input logic  [WIDTH-1:0]  data_i,
    output logic [WIDTH-1:0]  data_o,
    output logic full_o,
    output logic empty_o
);

 
logic [DEPTH-1:0] rptr,wptr;
typedef enum logic { stEmpty,stFull,stStill_free} state_t;
state_t cstate,nstate;
logic wptr_en,rptr_en;
always_ff @(posedge ck or negedge arst_ni) begin
    if (!arst_ni) begin
        cstate <= stEmpty;
    end else begin
        cstate <= nstate;
    end
        
end


always_comb begin
    nstate = cstate;
    wptr_en = 0;
    rptr_en = 0;
    case (cstate)
        stEmpty: begin
                if (wen_i)
                    nstate = stStill_free;
                    wptr_en ='1;
               end
        stStill_free: begin
                wptr_en = wen_i;
                rptr_en = ren_i;
                if (wptr == $unsigned(DEPTH-1))
                    nstate = stFull;
                else if (rptr == $unsigned(DEPTH-1))
                    nstate = stEmpty;
        end
        stFull: begin
            if (ren_i)
                nstate = still_free;
        end
    endcase
end

always_comb begin
    
end

always_ff @(posedge clk_i or negedge arst_ni) begin
    if (!arst_ni) begin
        wptr <= '0;
        rptr <= '0;

    end else begin
        rptr <= (rptr_en && rptr==$unsigned(DEPTH-1))? '0:(rptr_en)? rptr++:rptr;
        wptr <= (wptr_en && wptr==$unsigned(DEPTH-1))? '0:(wptr_en)? wptr++:wptr;
    end
        
end

assign full_o = cstate==stEmpty;
assign empty_o = cstate==stFull;
endmodule