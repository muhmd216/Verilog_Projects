module RegFile #(
    parameter WIDTH = 16,
              DEPTH = 8,
              ADDR  = 3
) (
    input wire [WIDTH-1:0] WrData,
    input wire [ADDR-1:0]  Address,
    input wire             WrEn,
    input wire             RdEn,
    input wire             CLK,
    input wire             RST,
    output reg [WIDTH-1:0] RdData
);

integer I ;

// register file of 8 registers each of 16 bits width
 reg [WIDTH-1:0] RegArray [DEPTH-1:0] ;

 always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        RdData <= 16'b0 ;
        for (I = 0 ; I < DEPTH ; I = I+1 ) begin
           RegArray[I] <= 16'b0 ; 
        end 
    end
    else if (WrEn && !RdEn) begin
           RegArray[Address] <= WrData ;
        end
    else if (!WrEn && RdEn) begin
        RdData <= RegArray[Address] ;
    end
    end
endmodule