module Logic_UNIT #(
    parameter in_data_width =16,
              out_data_width = 16
) (
   input  wire  [in_data_width-1:0]            a,
   input  wire  [in_data_width-1:0]            b,
   input  wire        [1:0]                    alu_fun,
   input  wire                                 clk,
   input  wire                                 rst,
   input  wire                                 logic_enable,
   output reg  [out_data_width-1:0]            logic_out,
   output reg                                  logic_flag
);

// internal signals declartion
reg [out_data_width-1:0]      logic_out_comb;
reg                           logic_flag_comb;

// Sequtional Logic
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        logic_out <= 16'b0 ;
        logic_flag <= 1'b0 ;   
    end
    else begin
        logic_out <= logic_out_comb ;
        logic_flag <= logic_flag_comb ;
    end 
end

// Combintional Logic
always @(*) begin
    logic_out_comb = 16'b0 ;
    logic_flag_comb = 1'b0 ;
    if (logic_enable) begin
       case (alu_fun)
        2'b00:begin
             logic_out_comb = a & b ;
             logic_flag_comb = 1'b1 ;
        end
        2'b01:begin
             logic_out_comb = a | b ;
             logic_flag_comb = 1'b1 ;
        end
        2'b10:begin
             logic_out_comb = ~(a & b) ;
             logic_flag_comb = 1'b1 ;
        end
        2'b11:begin
             logic_out_comb = ~(a | b) ;
             logic_flag_comb = 1'b1 ;
        end
       endcase 
    end
    
 end
endmodule