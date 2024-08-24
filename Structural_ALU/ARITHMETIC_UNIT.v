module ARITHMETIC_UNIT #(
    parameter in_data_width = 16,
              out_data_width = 32            
) (
   input  wire signed [in_data_width-1:0]      a,
   input  wire signed [in_data_width-1:0]      b,
   input  wire        [1:0]                    alu_fun,
   input  wire                                 clk,
   input  wire                                 rst,
   input  wire                                 arith_enable,
   output reg signed [out_data_width-1:0]      arith_out,
   output reg                                  carry_out,
   output reg                                  arith_flag
);

//Define Internal Signals
reg signed  [out_data_width-1:0] arith_out_comb;
wire                              arith_carry_comb;
reg                             arith_flag_comb;

// Regestering Arith unit outputs
always @(posedge clk or negedge rst) begin
    if (!rst) begin
     arith_out <= 32'b0;
     carry_out <= 1'b0;
     arith_flag <= 1'b0;   
    end
    else begin
     arith_out <= arith_out_comb ;
     carry_out <= arith_carry_comb;
     arith_flag <= arith_flag_comb ;
    end
end

//Define Arith Unit Functions 
 always @(*) begin
    arith_out_comb = 32'b0 ;
    arith_flag_comb = 1'b0 ;
    if (arith_enable) begin
       case (alu_fun)
        2'b00:begin
             arith_out_comb = a + b ;
             arith_flag_comb = 1'b1 ;
        end
        2'b01:begin
             arith_out_comb = a - b ;
             arith_flag_comb = 1'b1 ;
        end
        2'b10:begin
             arith_out_comb = a * b ;
             arith_flag_comb = 1'b1 ;
        end
        2'b11:begin
             arith_out_comb = a / b ;
             arith_flag_comb = 1'b1 ;
        end
       endcase 
    end
    
 end

 // define Carry
 assign arith_carry_comb = arith_out_comb[in_data_width] ;

endmodule