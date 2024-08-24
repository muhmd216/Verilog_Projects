`timescale 1us/1ns 

module Up_Dn_Counter_TB ();

//////////////////////////////////////////////////////////
/////////////////// DECLARE TB SIGNALS //////////////////
////////////////////////////////////////////////////////
 reg     [4:0]    IN_TB      ;
 reg              Load_TB    ;
 reg              Up_TB      ;
 reg              Down_TB   ;
 reg              CLK_TB     ;
 reg              RST_TB     ;
wire     [4:0]    Counter_TB ;
wire              High_TB    ;
wire              Low_TB     ;

parameter CLK_PERIOD = 10 ;    //Parametrize Clock period

//////////////////////////////////////////////////////////
/////////////////// INITIAL BLOCK ///////////////////////
////////////////////////////////////////////////////////
initial begin
   IN_TB   = 5'b00011 ;
   Load_TB = 1'b0 ;
   Down_TB = 1'b0 ;
   Up_TB   = 1'b0 ;       /////// initial values ///////
   CLK_TB  = 1'b0 ;
   RST_TB  = 1'b1 ;
   #CLK_PERIOD

   RST_TB = 1'b0 ;  // ACTIVATE RST
   #CLK_PERIOD 

   RST_TB = 1'b1 ; // DEACTIVATE RST
   #CLK_PERIOD
   
      $display("/////////////////// TEST CASE1 //////////////////////") ;

   Load_TB = 1'b1 ;
   #CLK_PERIOD
    
   if (Counter_TB == 5'b00011 ) begin
     $display ("***** TEST LOADING IS PASSED at Count vaule = 0%0d, High_Flag =0%0d, Low_Flag = 0%0d *****",Counter_TB,High_TB,Low_TB ) ;    
   end
   else begin
     $display ("***** TEST LOADING IS FAILD  at Count vaule = 0%0d, High_Flag =0%0d, Low_Flag = 0%0d *****",Counter_TB,High_TB,Low_TB ) ; 
   end

      $display("/////////////////// TEST CASE2 //////////////////////") ;
       
   Load_TB = 1'b0 ;
   Down_TB = 1'b1 ;
   Up_TB   = 1'b1 ;
   #CLK_PERIOD
    
   if (Counter_TB == 5'b00010 ) begin
     $display ("***** TEST DEC PER IS PASSED at Count vaule = 0%0d, High_Flag =0%0d, Low_Flag = 0%0d *****",Counter_TB,High_TB,Low_TB ) ;    
   end
   else begin
     $display ("***** TEST DEC PER IS FAILD  at Count vaule = 0%0d, High_Flag =0%0d, Low_Flag = 0%0d *****",Counter_TB,High_TB,Low_TB ) ; 
   end

      $display("/////////////////// TEST CASE3 //////////////////////") ;
       
   Load_TB = 1'b0 ;
   Down_TB = 1'b0 ;
   Up_TB   = 1'b1 ;
   #CLK_PERIOD
    
   if (Counter_TB == 5'b00011 ) begin
     $display ("***** TEST INCREM  IS PASSED at Count vaule = 0%0d, High_Flag =0%0d, Low_Flag = 0%0d *****",Counter_TB,High_TB,Low_TB ) ;    
   end
   else begin
     $display ("***** TEST INCREM  IS FAILD  at Count vaule = 0%0d, High_Flag =0%0d, Low_Flag = 0%0d *****",Counter_TB,High_TB,Low_TB ) ; 
   end

      $display("/////////////////// TEST CASE4 //////////////////////") ;
       
   Load_TB = 1'b0 ;
   Down_TB = 1'b1 ;
   Up_TB   = 1'b0 ;
   #(CLK_PERIOD * 5)   
   if (Counter_TB == 5'b00000 && Low_TB == 1'b1 ) begin
     $display ("***** TEST L_FLAG IS PASSED at Count vaule = 0%0d, High_Flag =0%0d, Low_Flag = 0%0d *****",Counter_TB,High_TB,Low_TB ) ;    
   end
   else begin
     $display ("***** TEST L_FLAG IS FAILD  at Count vaule = 0%0d, High_Flag =0%0d, Low_Flag = 0%0d *****",Counter_TB,High_TB,Low_TB ) ; 
   end

      $display("/////////////////// TEST CASE5 //////////////////////") ;
       
   Load_TB = 1'b0 ;
   Down_TB = 1'b0 ;
   Up_TB   = 1'b1 ;
   #(CLK_PERIOD * 35) 
    
   if (Counter_TB == 5'b11111 && High_TB == 1'b1 ) begin
     $display ("***** TEST H_FLAG IS PASSED at Count vaule = 0%0d, High_Flag =0%0d, Low_Flag = 0%0d *****",Counter_TB,High_TB,Low_TB ) ;    
   end
   else begin
     $display ("***** TEST H_FLAG IS FAILD  at Count vaule = 0%0d, High_Flag =0%0d, Low_Flag = 0%0d *****",Counter_TB,High_TB,Low_TB ) ; 
   end 

  #100 $stop ;
end

//////////////////////////////////////////////////////////
/////////////////// CLOCK GENERATOR /////////////////////
////////////////////////////////////////////////////////
always #(CLK_PERIOD/2) CLK_TB = ~CLK_TB ;

//////////////////////////////////////////////////////////
/////////////////// INSTANCTIATION //////////////////////
////////////////////////////////////////////////////////
Up_Dn_Counter DUT (
    .IN(IN_TB),
    .Load(Load_TB),
    .Up(Up_TB),
    .Down(Down_TB),
    .CLK(CLK_TB),
    .RST(RST_TB),
    .Counter(Counter_TB),
    .High(High_TB),
    .Low(Low_TB)
);

endmodule
