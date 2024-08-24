//Timescale
`timescale 1us/1ns

//testbench has no input or output
module ALU_TB (
);

    /////////////////////////////////////////////////////////////////////////
   ///// Declare testbench signals to drive inputs and monitor outputs /////
  /////////////////////////////////////////////////////////////////////////
  
reg [15:0]  A_TB ;
reg [15:0]  B_TB ;
reg [3:0]   ALU_FUN_TB ;  // Testbench signal for ALU function selector
reg         clk_TB;
wire [15:0] ALU_OUT_TB;   // Testbench wire to monitor ALU output
wire        Arith_Flag_TB;
wire        Logic_Flag_TB;
wire        CMP_Flag_TB;
wire        Shift_Flag_TB;

// Concatenate flags into a single 4-bit wire for easier monitoring
wire [3:0] flags;
assign flags = {Arith_Flag_TB,Logic_Flag_TB,CMP_Flag_TB,Shift_Flag_TB};

// Define the clock period parameter 
parameter CLK_PERIOD = 10 ;


    /////////////////////////////////////////////////////////////////////////
   //////////////// Initial block to start the simulation //////////////////
  /////////////////////////////////////////////////////////////////////////

initial begin
   // Setup waveform dump for simulation viewing (optional)
    $dumpfile("ALU.vcd") ; 
    $dumpvars ;

     // Initialize the clock signal
    clk_TB = 1'b0;
    
      $display ("****TEST CASE 1****"); // Test Addition

A_TB = 16'd15;
B_TB = 16'd10;
ALU_FUN_TB = 4'b0000;
#CLK_PERIOD
$display ("Addition  | Expected: 16'd25 | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'd25) ? "Passed" : "Failed");

      $display ("****TEST CASE 2****"); // Test Subtraction

A_TB = 16'd15;
B_TB = 16'd10;
ALU_FUN_TB = 4'b0001;
#CLK_PERIOD
$display ("Subtraction | Expected: 16'd5  | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'd5) ? "Passed" : "Failed");

      $display ("****TEST CASE 3****"); // Test Multiplication

A_TB = 16'd15;
B_TB = 16'd10;
ALU_FUN_TB = 4'b0010;
#CLK_PERIOD
$display ("Multiplication | Expected: 16'd150 | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'd150) ? "Passed" : "Failed");

      $display ("****TEST CASE 4****"); // Test Division

A_TB = 16'd15;
B_TB = 16'd10;
ALU_FUN_TB = 4'b0011;
#CLK_PERIOD
$display ("Division | Expected: 16'd1  | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'd1) ? "Passed" : "Failed");

      $display ("****TEST CASE 5****"); // Test AND

A_TB = 16'b10101;
B_TB = 16'b01010;
ALU_FUN_TB = 4'b0100;
#CLK_PERIOD
$display ("AND | Expected: 16'b00000 | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'b00000) ? "Passed" : "Failed");

      $display ("****TEST CASE 6****"); // Test OR

A_TB = 16'b10101;
B_TB = 16'b01010;
ALU_FUN_TB = 4'b0101;
#CLK_PERIOD
$display ("OR  | Expected: 16'b11111 | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'b11111) ? "Passed" : "Failed");

      $display ("****TEST CASE 7****"); // Test NAND

A_TB = 16'b10101;
B_TB = 16'b01010;
ALU_FUN_TB = 4'b0110;
#CLK_PERIOD
$display ("NAND | Expected: 16'hffff | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'hffff) ? "Passed" : "Failed");

      $display ("****TEST CASE 8****"); // Test NOR

A_TB = 16'b0101;
B_TB = 16'b1010;
ALU_FUN_TB = 4'b0111;
#CLK_PERIOD
$display ("NOR  | Expected: 16'hfff0 | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'hfff0) ? "Passed" : "Failed");

      $display ("****TEST CASE 9****"); // Test XOR

A_TB = 16'b10101;
B_TB = 16'b01010;
ALU_FUN_TB = 4'b1000;
#CLK_PERIOD
$display ("XOR  | Expected: 16'b11111 | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'b11111) ? "Passed" : "Failed");

      $display ("****TEST CASE 10****"); // Test XNOR

A_TB = 16'b0101;
B_TB = 16'b1010;
ALU_FUN_TB = 4'b1001;
#CLK_PERIOD
$display ("XNOR | Expected: 16'hfff0 | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'hfff0) ? "Passed" : "Failed");

      $display ("****TEST CASE 11****"); // Test Equality

A_TB = 16'b10101;
B_TB = 16'b10101;
ALU_FUN_TB = 4'b1010;
#CLK_PERIOD
$display ("Equal | Expected: 16'b00001 | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'b00001) ? "Passed" : "Failed");

      $display ("****TEST CASE 12****"); // Test Greater Than

A_TB = 16'b11101;
B_TB = 16'b10101;
ALU_FUN_TB = 4'b1011;
#CLK_PERIOD
$display ("Greater | Expected: 16'b00010 | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'b00010) ? "Passed" : "Failed");

      $display ("****TEST CASE 13****"); // Test Less Than

A_TB = 16'b10101;
B_TB = 16'b11101;
ALU_FUN_TB = 4'b1100;
#CLK_PERIOD
$display ("Less | Expected: 16'b00011 | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'b00011) ? "Passed" : "Failed");

      $display ("****TEST CASE 14****"); // Test Shift Right

A_TB = 16'b10011;
ALU_FUN_TB = 4'b1101;
#CLK_PERIOD
$display ("Shift Right | Expected: 16'b01001 | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'b01001) ? "Passed" : "Failed");

      $display ("****TEST CASE 15****"); // Test Shift Left

A_TB = 16'b10011;
ALU_FUN_TB = 4'b1110;
#CLK_PERIOD
$display ("Shift Left | Expected: 16'b100110 | Result: %0h | Time: %0t | %s", ALU_OUT_TB, $time, (ALU_OUT_TB == 16'b100110) ? "Passed" : "Failed");

#100 $finish ;//Finish simulation 

end

  /////////////////////////////////////////////////////////////////////////
 //////////////// Instantiate the ALU module for testing /////////////////
/////////////////////////////////////////////////////////////////////////

ALU DUT3 (
    .A(A_TB),
    .B(B_TB),
    .ALU_FUN(ALU_FUN_TB),
    .clk(clk_TB),
    .ALU_OUT(ALU_OUT_TB),
    .Arith_Flag(Arith_Flag_TB),
    .Logic_Flag(Logic_Flag_TB),
    .Shift_Flag(Shift_Flag_TB),
    .CMP_Flag(CMP_Flag_TB)
);

  /////////////////////////////////////////////////////////////////////////
 ////////////////////////// Clock Generator //////////////////////////////
/////////////////////////////////////////////////////////////////////////

always #(CLK_PERIOD/2) clk_TB = ~clk_TB ;

endmodule