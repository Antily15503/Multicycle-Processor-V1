`default_nettype none
module fetch(
    // clk and reset
    input clk,
    input rst_n,

    // Data Inputs
    input [63:0] icache_instr_in1, icache_instr_in2, icache_instr_in3, icache_instr_in4,
    input icache_valid1, icache_valid2, icache_valid3, icache_valid4,
    input [63:0] branch_predict1, branch_predict2, branch_predict3, branch_predict4,
    input branch_predict_taken1, branch_predict_taken2, branch_predict_taken3, branch_predict_taken4,
    input [63:0] peek,
    input peek_valid 

    // Control Inputs
    input flush,
    input [63:0] branch_addr,
    input istall,
    input cap_stall,

    // Outputs
    output [63:0] instr1, instr2, instr3, instr4,
    output [63:0] branch_target1, branch_target2, branch_target3, branch_target4,
    output branch_valid1, branch_valid2, branch_valid3, branch_valid4,
)
    /**********************************  PRELIMINARY INSTRUCTION MUXES  ******************************************/ 
    // Selects the instruction to be used based on the validity of the incoming instructions
    // outputs: [63:0] instr_q1, instr_q2, instr_q3, instr_q4

    // replacing incoming instructions (icache_instr_in) with NOPs if they are not valid
    /*wire [63:0] instr1_nop, instr2_nop, instr3_nop, instr4_nop;
    assign instr1_nop = icache_valid1 ? icache_instr_in1 : 64'h0000000000000000;
    assign instr2_nop = icache_valid2 ? icache_instr_in2 : 64'h0000000000000000;
    assign instr3_nop = icache_valid3 ? icache_instr_in3 : 64'h0000000000000000;
    assign instr4_nop = icache_valid4 ? icache_instr_in4 : 64'h0000000000000000;*/
    //FIXME: this is probably not the right implementation, I might be stupid

    // replaces incoming instructions with branch predictions if they are valid

    // maintains current instructions if stall is asserted (TODO: how to implement this?)
    /**********************************  INSTRUCTION STORING FLOPS  ******************************************/ 
    // Selects the instruction to be used based on the validity of the incoming instructions
    //outputs: [63:0] instr_1, instr_2, instr_3, instr_4
    always_ff @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            instr1 <= '0;
            instr2 <= '0;
            instr3 <= '0;
            instr4 <= '0;
        end else begin 
            instr1 <= instr1_q1;
            instr2 <= instr2_q2;
            instr3 <= instr3_q3;
            instr4 <= instr4_q4;
        end
    end 

endmodule