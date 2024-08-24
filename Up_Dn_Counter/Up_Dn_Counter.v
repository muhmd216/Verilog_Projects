module Up_Dn_Counter (
    input wire [4:0]  IN,      //input count value
    input wire        Load,    
    input wire        Up,      //Count up if "HIGH"
    input wire        Down,    //Count down if "HIGH"
    input wire        CLK,     
    input wire        RST,
    output reg [4:0]  Counter, // Current Count Value 
    output reg        High,    // This flag will be high if Count vaule equal 31
    output reg        Low      // This flag will be high if Count vaule equal 0
);

  ////////////////////////////////////
 //////// SIGNSL DECLARATION ////////
////////////////////////////////////

reg [4:0] Counter_comb ;

  ///////////////////////////////////
 //////// Sequentional Circuit /////
///////////////////////////////////

always @(posedge CLK or negedge RST) begin
    if (!RST) begin
        Counter <= 5'b0 ;
    end
    else begin
        Counter <= Counter_comb ;
    end  
end

  ////////////////////////////////////
 //////// Combinational Circuit /////
////////////////////////////////////

always @(*) begin
    Counter_comb = 5'b0 ;
    if (Load) begin
        Counter_comb = IN ;
    end
    else if (Down && !Low) begin
        Counter_comb = Counter - 5'b1 ;
    end                                    //use counter not counter_comb to Avoid "Combintional Loop"
    else if (Up && !Down &&!High) begin
        Counter_comb = Counter + 5'b1 ;
    end
    else begin
        Counter_comb = Counter ;
    end  
end

  ////////////////////////////////////
 ///////////// FLAGS ////////////////
////////////////////////////////////

/*
assign High = (Counter_comb == 5'b11111);
assign Low  = (Counter_comb == 5'b0);
*/

////////OR YOU Can Use Always Block/////////
 
 always @(*) begin
    if (Counter == 5'b11111) begin
        High = 1'b1 ;
        Low  = 1'b0 ;
    end                                 //use counter not counter_comb to Avoid "Iteration limit issue"
    else if (Counter == 5'b0) begin
        Low  = 1'b1 ;
        High = 1'b0 ;
    end
    else begin
        High = 1'b0 ;         // avoid latch
        Low  = 1'b0 ;
    end  
 end
 


endmodule