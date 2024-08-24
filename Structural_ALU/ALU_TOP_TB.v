`timescale 1us/1us

module ALU_TOP_TB ();

/*****************************************************************************/
/***************************** TB Parameters *********************************/
/*****************************************************************************/

parameter OP_DATA_WIDTH_TB = 16,
          Arith_OUT_WIDTH_TB = OP_DATA_WIDTH_TB + OP_DATA_WIDTH_TB,
          Logic_OUT_WIDTH_TB = OP_DATA_WIDTH_TB,
          Shift_OUT_WIDTH_TB = OP_DATA_WIDTH_TB,
          CMP_OUT_WIDTH_TB   = 2 ; 

//Clock Period
parameter CLK_PERIOD = 10,
          HIGH_PERIOD = CLK_PERIOD * 0.6 ,
          LOW_PERIOD = CLK_PERIOD * 0.4 ;

/*****************************************************************************/
/***************************** TB Signals ************************************/
/*****************************************************************************/

    reg  signed [OP_DATA_WIDTH_TB-1:0]      A_TB ;
    reg  signed [OP_DATA_WIDTH_TB-1:0]      B_TB ;
    reg         [3:0]                       ALU_FUN_TB ;
    reg                                     CLK_TB ;
    reg                                     RST_TB ;
    wire signed [Arith_OUT_WIDTH_TB-1:0]    Arith_OUT_TB ;
    wire                                    Carry_OUT_TB ;
    wire                                    Arith_Flag_TB ;
    wire        [Logic_OUT_WIDTH_TB-1:0]    Logic_OUT_TB ;
    wire                                    Logic_Flag_TB ;
    wire        [CMP_OUT_WIDTH_TB-1:0]      CMP_OUT_TB ;
    wire                                    CMP_Flag_TB ;
    wire        [Shift_OUT_WIDTH_TB-1:0]    Shift_OUT_TB ;
    wire                                    Shift_Flag_TB ;

//Concatenate Flags
wire [3:0] Flags ;
assign Flags = {Arith_Flag_TB,Logic_Flag_TB,CMP_Flag_TB,Shift_Flag_TB} ;

/*****************************************************************************/
/***************************** INTIAL BLOCK **********************************/
/*****************************************************************************/

initial begin
   $dumpfile ("ALU.vcd") ;
   $dumpvars ;

//Initial Values
CLK_TB = 1'b0 ;
RST_TB = 1'b1 ;

//RST ACTIVATION
#CLK_PERIOD
RST_TB = 1'b0 ;

//RST DE-ACTIVATION
#CLK_PERIOD
RST_TB = 1'b1 ;

      $display ("*** TEST CASE 1 --Addition-- NEG + NEG ***") ;

A_TB = -'d4 ;
B_TB = -'d5 ;
ALU_FUN_TB = 4'b0000 ;

#CLK_PERIOD

      if (Arith_OUT_TB == -'d9 && Flags == 4'b1000) begin
         $display ("Addition %0d + %0d IS PASSED = %0d ",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Addition %0d + %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 2 --Addition-- POS + NEG ***") ;

A_TB =  'd4 ;
B_TB = -'d5 ;
ALU_FUN_TB = 4'b0000 ;

#CLK_PERIOD

      if (Arith_OUT_TB == -'d1 && Flags == 4'b1000) begin
         $display ("Addition %0d + %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Addition %0d + %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 3 --Addition-- NEG + POS ***") ;

A_TB = -'d4 ;
B_TB =  'd5 ;
ALU_FUN_TB = 4'b0000 ;

#CLK_PERIOD

      if (Arith_OUT_TB ==  'd1 && Flags == 4'b1000) begin
         $display ("Addition %0d + %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Addition %0d + %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 4 --Addition-- POS + POS ***") ;

A_TB = 'hffff ;
B_TB = 'hffff ;
ALU_FUN_TB = 4'b0000 ;

#CLK_PERIOD

      if (Arith_OUT_TB ==  'h1fffe && Flags == 4'b1000) begin
         $display ("Addition %0d + %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Addition %0d + %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 5 --Subtraction-- NEG - NEG ***") ;

A_TB = -'d4 ;
B_TB = -'d5 ;
ALU_FUN_TB = 4'b0001 ;

#CLK_PERIOD

      if (Arith_OUT_TB ==  'd1 && Flags == 4'b1000) begin
         $display ("Subtraction %0d - %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Subtraction %0d - %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 6 --Subtraction-- POS - NEG ***") ;

A_TB =  'd4 ;
B_TB = -'d5 ;
ALU_FUN_TB = 4'b0001 ;

#CLK_PERIOD

      if (Arith_OUT_TB ==  'd9 && Flags == 4'b1000) begin
         $display ("Subtraction %0d - %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Subtraction %0d - %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 7 --Subtraction-- NEG - POS ***") ;

A_TB = -'d4 ;
B_TB =  'd5 ;
ALU_FUN_TB = 4'b0001 ;

#CLK_PERIOD

      if (Arith_OUT_TB ==  -'d9 && Flags == 4'b1000) begin
         $display ("Subtraction %0d - %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Subtraction %0d - %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 8 --Subtraction-- POS - POS ***") ;

A_TB =  'd4 ;
B_TB =  'd5 ;
ALU_FUN_TB = 4'b0001 ;

#CLK_PERIOD

      if (Arith_OUT_TB ==  -'d1 && Flags == 4'b1000) begin
         $display ("Subtraction %0d - %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Subtraction %0d - %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 9 --Multiplication-- NEG * NEG ***") ;

A_TB =  -'d4 ;
B_TB =  -'d5 ;
ALU_FUN_TB = 4'b0010 ;

#CLK_PERIOD

      if (Arith_OUT_TB ==  'd20 && Flags == 4'b1000) begin
         $display ("Multiplication %0d * %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Multiplication %0d * %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 10 --Multiplication-- POS * NEG ***") ;

A_TB =   'd4 ;
B_TB =  -'d5 ;
ALU_FUN_TB = 4'b0010 ;

#CLK_PERIOD

      if (Arith_OUT_TB ==  -'d20 && Flags == 4'b1000) begin
         $display ("Multiplication %0d * %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Multiplication %0d * %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 11 --Multiplication-- NEG * POS ***") ;

A_TB =  -'d4 ;
B_TB =   'd5 ;
ALU_FUN_TB = 4'b0010 ;

#CLK_PERIOD

      if (Arith_OUT_TB ==  -'d20 && Flags == 4'b1000) begin
         $display ("Multiplication %0d * %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Multiplication %0d * %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 12 --Multiplication-- POS * POS ***") ;

A_TB =   'd4 ;
B_TB =   'd5 ;
ALU_FUN_TB = 4'b0010 ;

#CLK_PERIOD

      if (Arith_OUT_TB ==  'd20 && Flags == 4'b1000) begin
         $display ("Multiplication %0d * %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Multiplication %0d * %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 13 --Division-- NEG / NEG ***") ;

A_TB =   -'d10 ;
B_TB =   -'d5 ;
ALU_FUN_TB = 4'b0011 ;

#CLK_PERIOD

      if (Arith_OUT_TB ==  'd2 && Flags == 4'b1000) begin
         $display ("Divsion %0d / %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Divsion %0d / %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 14 --Division-- POS / NEG ***") ;

A_TB =    'd10 ;
B_TB =   -'d5 ;
ALU_FUN_TB = 4'b0011 ;

#CLK_PERIOD

      if (Arith_OUT_TB ==  -'d2 && Flags == 4'b1000) begin
         $display ("Divsion %0d / %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Divsion %0d / %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 15 --Division-- POS / NEG ***") ;

A_TB =   -'d10 ;
B_TB =    'd5 ;
ALU_FUN_TB = 4'b0011 ;

#CLK_PERIOD

      if (Arith_OUT_TB ==  -'d2 && Flags == 4'b1000) begin
         $display ("Divsion %0d / %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Divsion %0d / %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 16 --Division-- POS / POS ***") ;

A_TB =    'd10 ;
B_TB =    'd5 ;
ALU_FUN_TB = 4'b0011 ;

#CLK_PERIOD

      if (Arith_OUT_TB ==  'd2 && Flags == 4'b1000) begin
         $display ("Divsion %0d / %0d IS PASSED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end
      else begin
         $display ("Divsion %0d / %0d IS FAILED = %0d",A_TB,B_TB,Arith_OUT_TB);
      end

     $display ("*** TEST CASE 17 --ANDING-- ***") ;

A_TB =    'b0101 ;
B_TB =    'b1011 ;
ALU_FUN_TB = 4'b0100 ;

#CLK_PERIOD

      if (Logic_OUT_TB ==  'b0001 && Flags == 4'b0100) begin
         $display (" ANDING IS PASSED ");
      end
      else begin
         $display (" ANDING IS FAILED ");
      end

     $display ("*** TEST CASE 18 --ORING-- ***") ;

A_TB =    'b0001 ;
B_TB =    'b1011 ;
ALU_FUN_TB = 4'b0101 ;

#CLK_PERIOD

      if (Logic_OUT_TB ==  'b1011 && Flags == 4'b0100) begin
         $display ("ORING IS PASSED");
      end
      else begin
         $display ("ORING IS FAILED");
      end

     $display ("*** TEST CASE 19 --NANDING-- ***") ;

A_TB =    'b0001 ;
B_TB =    'b1011 ;
ALU_FUN_TB = 4'b0110 ;

#CLK_PERIOD

      if (Logic_OUT_TB ==  'hfffe && Flags == 4'b0100) begin
         $display ("NANDING IS PASSED ");
      end
      else begin
         $display ("NANDING FAILED");
      end

     $display ("*** TEST CASE 20 --NORING-- ***") ;

A_TB =    'b0001 ;
B_TB =    'b1011 ;
ALU_FUN_TB = 4'b0111 ;

#CLK_PERIOD

      if (Logic_OUT_TB ==  'hfff4 && Flags == 4'b0100) begin
         $display ("NORING IS PASSED");
      end
      else begin
         $display ("NORING IS FAILED");
      end

     $display ("*** TEST CASE 21 --CMP_NOP-- ***") ;

A_TB =    'd5 ;
B_TB =    'd4 ;
ALU_FUN_TB = 4'b1000 ;

#CLK_PERIOD

      if (CMP_OUT_TB ==  3'd0 && Flags == 4'b0010) begin
         $display ("CMP_NOP IS PASSED");
      end
      else begin
         $display ("CMP_NOP IS FAILED");
      end

     $display ("*** TEST CASE 22 --CMP_EQ-- ***") ;

A_TB =    'd5 ;
B_TB =    'd5 ;
ALU_FUN_TB = 4'b1001 ;

#CLK_PERIOD

      if (CMP_OUT_TB ==  3'd1 && Flags == 4'b0010) begin
         $display ("CMP_EQ IS PASSED");
      end
      else begin
         $display ("CMP_EQ IS FAILED");
      end

     $display ("*** TEST CASE 23 --CMP_GR-- ***") ;

A_TB =    'd5 ;
B_TB =    'd4 ;
ALU_FUN_TB = 4'b1010 ;

#CLK_PERIOD

      if (CMP_OUT_TB ==  3'd2 && Flags == 4'b0010) begin
         $display ("CMP_GR IS PASSED");
      end
      else begin
         $display ("CMP_GR IS FAILED");
      end

     $display ("*** TEST CASE 24 --CMP_LE-- ***") ;

A_TB =    'd4 ;
B_TB =    'd5 ;
ALU_FUN_TB = 4'b1011 ;

#CLK_PERIOD

      if (CMP_OUT_TB ==  3'd3 && Flags == 4'b0010) begin
         $display ("CMP_LE IS PASSED");
      end
      else begin
         $display ("CMP_LE IS FAILED");
      end

     $display ("*** TEST CASE 25 --A_SHIFT_R-- ***") ;

A_TB =    'b0101 ;
B_TB =    'b1010 ;
ALU_FUN_TB = 4'b1100 ;

#CLK_PERIOD

      if (Shift_OUT_TB ==  'b0010 && Flags == 4'b0001) begin
         $display ("A_SHIFT_R IS PASSED");
      end
      else begin
         $display ("A_SHIFT_R IS FAILED");
      end

     $display ("*** TEST CASE 25 --A_SHIFT_R-- ***") ;

A_TB =    'b0101 ;
B_TB =    'b1010 ;
ALU_FUN_TB = 4'b1100 ;

#CLK_PERIOD

      if (Shift_OUT_TB ==  'b0010 && Flags == 4'b0001) begin
         $display ("A_SHIFT_R IS PASSED");
      end
      else begin
         $display ("A_SHIFT_R IS FAILED");
      end

     $display ("*** TEST CASE 26 --A_SHIFT_L-- ***") ;

A_TB =    'b0101 ;
B_TB =    'b1010 ;
ALU_FUN_TB = 4'b1101 ;

#CLK_PERIOD

      if (Shift_OUT_TB ==  'b1010 && Flags == 4'b0001) begin
         $display ("A_SHIFT_L IS PASSED");
      end
      else begin
         $display ("A_SHIFT_L IS FAILED");
      end

     $display ("*** TEST CASE 27 --B_SHIFT_R-- ***") ;

A_TB =    'b0101 ;
B_TB =    'b1010 ;
ALU_FUN_TB = 4'b1110 ;

#CLK_PERIOD

      if (Shift_OUT_TB ==  'b0101 && Flags == 4'b0001) begin
         $display ("B_SHIFT_R IS PASSED");
      end
      else begin
         $display ("B_SHIFT_R IS FAILED");
      end


     $display ("*** TEST CASE 28 --B_SHIFT_L-- ***") ;

A_TB =    'b0101 ;
B_TB =    'b1010 ;
ALU_FUN_TB = 4'b1111 ;

#CLK_PERIOD

      if (Shift_OUT_TB ==  'b10100 && Flags == 4'b0001) begin
         $display ("B_SHIFT_L IS PASSED");
      end
      else begin
         $display ("B_SHIFT_L IS FAILED");
      end

#100 $stop ; //Finished With Simulation

end

/*****************************************************************************/
/***************************** CLOCK GENERATOR *******************************/
/*****************************************************************************/
 always begin
   #LOW_PERIOD CLK_TB = ~CLK_TB ;
   #HIGH_PERIOD CLK_TB = ~CLK_TB ;
 end

/*****************************************************************************/
/***************************** INSTANCTIATION *******************************/
/*****************************************************************************/
ALU_TOP #(.OP_DATA_WIDTH(OP_DATA_WIDTH_TB),
          .Arith_OUT_WIDTH(Arith_OUT_WIDTH_TB),
          .Logic_OUT_WIDTH(Logic_OUT_WIDTH_TB),
          .Shift_OUT_WIDTH(Shift_OUT_WIDTH_TB),
          .CMP_OUT_WIDTH(CMP_OUT_WIDTH_TB)) U5 (
            .A(A_TB),
            .B(B_TB),
            .ALU_FUN(ALU_FUN_TB),
            .CLK(CLK_TB),
            .RST(RST_TB),
            .Arith_OUT(Arith_OUT_TB),
            .Carry_OUT(Carry_OUT_TB),
            .Arith_Flag(Arith_Flag_TB),
            .Logic_OUT(Logic_OUT_TB),
            .Logic_Flag(Logic_Flag_TB),
            .CMP_OUT(CMP_OUT_TB),
            .CMP_Flag(CMP_Flag_TB),
            .Shift_OUT(Shift_OUT_TB),
            .Shift_Flag(Shift_Flag_TB)
          ) ;
endmodule