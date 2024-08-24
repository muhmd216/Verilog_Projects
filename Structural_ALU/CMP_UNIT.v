module CMP_UNIT #(
    parameter in_data_width =16,
              out_data_width = 2
) (
   input  wire  [in_data_width-1:0]            a,
   input  wire  [in_data_width-1:0]            b,
   input  wire        [1:0]                    alu_fun,
   input  wire                                 clk,
   input  wire                                 rst,
   input  wire                                 cmp_enable,
   output reg    [out_data_width-1:0]          cmp_out,
   output reg                                  cmp_flag
);

// internal signals declartion
reg          [1:0]            cmp_out_comb;
reg                           cmp_flag_comb;

// Sequential always
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        cmp_out <= 2'b0 ;
        cmp_flag <= 1'b0 ;   
    end
    else begin
        cmp_out <= cmp_out_comb ;
        cmp_flag <= cmp_flag_comb ;
    end 
end

// Combinational always
always @(*) begin
    cmp_out_comb = 2'b0 ;
    cmp_flag_comb = 1'b0 ;
    if (cmp_enable) begin
        cmp_flag_comb = 1'b1 ;
       case (alu_fun)
        2'b00:begin
             cmp_out_comb = 2'b0 ;   
        end
        2'b01:begin if (a == b)begin
             cmp_out_comb = 2'b01 ;
        end
        else begin
           cmp_out_comb = 2'b00 ; 
        end
              
        end
        2'b10: begin if (a > b)begin
             cmp_out_comb = 2'b10 ;
        end
        else begin
           cmp_out_comb = 2'b00 ; 
        end
        end
        2'b11: begin if (a < b)begin
             cmp_out_comb = 2'b11 ;
        end
        else begin
           cmp_out_comb = 2'b00 ; 
        end
        end
       endcase 
    end
    
 end
endmodule
