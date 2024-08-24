module Decoder (
    input wire [1:0]  alu_fun,
    input wire        rst,
    output wire       arith_enable,
    output wire       logic_enable,
    output wire       cmp_enable,
    output wire       shift_enable
);

// concatonate 
 reg [3:0] deco ;
assign {arith_enable,logic_enable,cmp_enable,shift_enable} = deco;

 // Combinational logic
 always @(*) begin
    if (!rst) begin
        deco = 4'b0000 ;
    end
    else begin
        deco = 4'b0000 ;
        case (alu_fun)
           2'b00 : deco = 4'b1000 ;
           2'b01 : deco = 4'b0100 ;
           2'b10 : deco = 4'b0010 ;
           2'b11 : deco = 4'b0001 ;
            default: deco = 4'b0000 ; 
        endcase
    end
 end   
endmodule