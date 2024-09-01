`timescale 1ns/1ps

module LFSR_TB ();

  /////////////////////////////////////////////////
 ///////////////// Parameters ////////////////////
/////////////////////////////////////////////////

parameter LFSR_WD_TB = 8 ;
parameter CLK_PERIOD = 10;
parameter Cases_Num = 5 ;

  /////////////////////////////////////////////////
 ///////////////// TB Signals ////////////////////
/////////////////////////////////////////////////

reg     [LFSR_WD_TB-1:0]    Seed_TB ;
reg                         CLK_TB ;
reg                         RST_TB ;
reg                         Enable_TB ;
reg                         OUT_Enable_TB ;
wire                        OUT_TB ;
wire                        Valid_TB ;

/////////////////////////////////////////////////////////
///////////////// Loops Variables ///////////////////////
/////////////////////////////////////////////////////////
integer N ;

  /////////////////////////////////////////////////
 //////////////// Memories ///////////////////////
/////////////////////////////////////////////////
reg [LFSR_WD_TB-1:0] Test_Seeds [Cases_Num-1:0] ;
reg [LFSR_WD_TB-1:0] Expec_Outs [Cases_Num-1:0] ;

  /////////////////////////////////////////////////
 //////////////// INTIAL BLOCK ///////////////////
/////////////////////////////////////////////////

initial begin
   
 // System Functions
 $dumpfile("LFSR_DUMP.vcd") ;       
 $dumpvars; 

 // Read Input Files
 $readmemb("Seeds_b.txt",Test_Seeds) ;
 $readmemb("Expec_Out_b.txt",Expec_Outs) ;

initialize () ;
//#CLK_PERIOD
for (N=0; N<5; N=N+1)begin
  do_oper(Test_Seeds[N]) ;
  check_out(Expec_Outs[N],N) ;
end

#100 
$finish ;

end


  /////////////////////////////////////////////////
 //////////////////// TASKS //////////////////////
/////////////////////////////////////////////////

//////////////////// RESET ////////////////////
task reset ;
begin
   RST_TB = 1'b1 ;
   #CLK_PERIOD
   RST_TB = 1'b0 ;
   #CLK_PERIOD 
   RST_TB = 1'b1 ;
end
endtask

//////////////////// initialize ////////////////////
task initialize ;
begin
    Seed_TB       = 'b10010011 ;
    CLK_TB        = 'b0 ;
    RST_TB        = 'b0 ;
    OUT_Enable_TB = 'b0 ;
    Enable_TB     = 'b0 ;
end 
endtask

//////////////////// Do LFSR operation  ////////////////////
task do_oper ;
input  [LFSR_WD_TB-1:0]     IN_Seed ;
begin
Seed_TB = IN_Seed ;
reset() ;
#(CLK_PERIOD) 
Enable_TB = 1'b1 ;
#(10*CLK_PERIOD)
Enable_TB = 1'b0 ;
end
endtask

//////////////////// Ckeck Output Response ////////////////////
task check_out ;
input  reg     [LFSR_WD_TB-1:0]     expec_out ;
input integer oper_num ;

integer i ;
reg [LFSR_WD_TB-1:0] Respo ; 
begin
Enable_TB = 1'b0 ;
#(CLK_PERIOD)
OUT_Enable_TB = 1'b1 ;
 @(posedge Valid_TB)
  for (i=0; i<8; i=i+1) begin
    #(CLK_PERIOD)
    Respo[i] = OUT_TB ;
  end
  if(Respo == expec_out )begin
    $display("Test Case %d is Passed",oper_num+1) ;
  end
  else begin
    $display("Test Case %d is Faild",oper_num+1) ;

  end
  OUT_Enable_TB = 1'b0 ;

end
endtask


  /////////////////////////////////////////////////
 /////////////// CLOCK GENERATOR /////////////////
/////////////////////////////////////////////////

always #(CLK_PERIOD/2) CLK_TB = ~CLK_TB;

  /////////////////////////////////////////////////
 /////////////// INSTANCTIATION   ////////////////
/////////////////////////////////////////////////

LFSR #(.LFSR_WD(LFSR_WD_TB)) DUT (
    .Seed(Seed_TB),
    .CLK(CLK_TB),
    .RST(RST_TB),
    .Enable(Enable_TB),
    .OUT_Enable(OUT_Enable_TB),
    .OUT(OUT_TB),
    .Valid(Valid_TB)
);
endmodule