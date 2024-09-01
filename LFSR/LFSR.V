module LFSR #(parameter LFSR_WD = 8) (
    input wire [LFSR_WD-1:0] Seed,
    input wire       CLK,
    input wire       RST,
    input wire       Enable,
    input wire       OUT_Enable,
    output reg       OUT,
    output reg       Valid
);

wire  NOR_OUT,Feedback ;
reg [LFSR_WD-1:0] LFSR ;

assign NOR_OUT = ~| LFSR[LFSR_WD-2:0] ;
assign Feedback = LFSR[LFSR_WD-1] ^ NOR_OUT ;

integer N ;

parameter [LFSR_WD-1:0] Tap = 8'b10101010 ;

always @(posedge CLK or negedge RST) begin
    if(!RST) begin
        LFSR <= Seed ;
        OUT <= 1'b0 ;
        Valid <= 1'b0 ;
    end
    else if (Enable) begin
        LFSR[0] <= Feedback ;
        for(N = (LFSR_WD-1); N >= 1; N = N-1)
            if (Tap[N] == 1) begin
                LFSR[N] <= Feedback ^ LFSR[N-1] ; 
            end
            else begin
               LFSR[N] <= LFSR[N-1] ;   
            end
        
    end
    else if (OUT_Enable) begin
        {LFSR[LFSR_WD-1:0],OUT} <= LFSR ;
        Valid <= 1'b1 ;
    end


end

endmodule