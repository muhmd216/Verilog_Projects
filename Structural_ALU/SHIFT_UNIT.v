module Shift_UNIT #(
    parameter in_data_width =16,
              out_data_width = 16
) (
   input  wire  [in_data_width-1:0]            a,
   input  wire  [in_data_width-1:0]            b,
   input  wire        [1:0]                    alu_fun,
   input  wire                                 clk,
   input  wire                                 rst,
   input  wire                                 shift_enable,
   output reg  [out_data_width-1:0]            shift_out,
   output reg                                  shift_flag
);

// internal signals declartion
reg [out_data_width-1:0]      shift_out_comb;
reg                           shift_flag_comb;

// Sequential always
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        shift_out <= 16'b0 ;
        shift_flag <= 1'b0 ;   
    end
    else begin
        shift_out <= shift_out_comb ;
        shift_flag <= shift_flag_comb ;
    end 
end

// Combinational always
always @(*) begin
    shift_out_comb = 16'b0 ;
    shift_flag_comb = 1'b0 ;
    if (shift_enable) begin
       case (alu_fun)
        2'b00:begin
             shift_out_comb = a >> 1 ;
             shift_flag_comb = 1'b1 ;
        end
        2'b01:begin
             shift_out_comb = a << 1 ;
             shift_flag_comb = 1'b1 ;
        end
        2'b10:begin
             shift_out_comb = b >> 1 ;
             shift_flag_comb = 1'b1 ;
        end
        2'b11:begin
             shift_out_comb = b << 1 ;
             shift_flag_comb = 1'b1 ;
        end
       endcase 
    end
    
 end
endmodule
