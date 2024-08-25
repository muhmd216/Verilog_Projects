`timescale 1us/1ns

module RegFile_TB ();

/***********************************************/
/*************** TB Parameters *****************/
/***********************************************/

parameter WIDTH_TB = 16,
          DEPTH_TB = 8,
          ADDR_TB  = 3,
          CLK_PERIOD = 10 ;

/***********************************************/
/*************** TB Signals ********************/
/***********************************************/

 reg [WIDTH_TB-1:0] WrData_TB ;
 reg [ADDR_TB-1:0]  Address_TB ;
 reg                WrEn_TB ;
 reg                RdEn_TB ;
 reg                CLK_TB ;
 reg                RST_TB ;
 wire [WIDTH_TB-1:0] RdData_TB ;

 /***********************************************/
 /************* TB INITIAL BLOCK ****************/
/***********************************************/

initial begin
    $dumpfile ("RegFile.vcd");
    $dumpvars ;

// Intial Values
CLK_TB = 1'b0 ;
RST_TB = 1'b1 ;
WrEn_TB = 1'b0 ;
RdEn_TB = 1'b0 ;
Address_TB = 3'b000;

#CLK_PERIOD

//Activate RST
RST_TB = 1'b0 ;

//Deactivate RST
#CLK_PERIOD
RST_TB = 1'b1;
WrEn_TB = 1'b1 ;
Address_TB = 3'b000;
WrData_TB = 16'b1110 ;

#CLK_PERIOD 

WrEn_TB = 1'b1 ;
Address_TB = 3'b001;
WrData_TB = 16'b1101 ;

#CLK_PERIOD 

WrEn_TB = 1'b1 ;
Address_TB = 3'b010;
WrData_TB = 16'b1011 ;

#CLK_PERIOD 

WrEn_TB = 1'b1 ;
Address_TB = 3'b011;
WrData_TB = 16'b0111 ;

#CLK_PERIOD 

  $display ("TEST CASE 1 -- REG[0]") ;

WrEn_TB = 1'b0 ;
RdEn_TB = 1'b1 ;
Address_TB = 3'b000;
  
#CLK_PERIOD

if (RdData_TB == 'b1110) begin
    $display ("TEST IS PASSED") ;
end
else begin
    $display ("TEST IS FAILED") ;
end

	$display ("TEST CASE 2 -- REG[1]") ;

WrEn_TB = 1'b0 ;
RdEn_TB = 1'b1 ;
Address_TB = 3'b001;

#CLK_PERIOD

if (RdData_TB == 'b1101) begin
    $display ("TEST IS PASSED") ;
end
else begin
    $display ("TEST IS FAILED") ;
end

	$display ("TEST CASE 3 -- REG[2]") ;

WrEn_TB = 1'b0 ;
RdEn_TB = 1'b1 ;
Address_TB = 3'b010;

#CLK_PERIOD

if (RdData_TB == 'b1011) begin
    $display ("TEST IS PASSED") ;
end
else begin
    $display ("TEST IS FAILED") ;
end

$display ("TEST CASE 4 -- REG[3]") ;

WrEn_TB = 1'b0 ;
RdEn_TB = 1'b1 ;
Address_TB = 3'b011;

#CLK_PERIOD

if (RdData_TB == 'b0111) begin
    $display ("TEST IS PASSED") ;
end
else begin
    $display ("TEST IS FAILED") ;
end

#100 $stop ; //Finished with simulation

end

/***********************************************/
 /************* CLOCK GENERATOR ****************/
/***********************************************/

always #(CLK_PERIOD/2) CLK_TB = ~CLK_TB ;

/***********************************************/
 /************* INSTANCTIATION ****************/
/***********************************************/

RegFile #(.WIDTH(WIDTH_TB),
          .DEPTH(DEPTH_TB),
          .ADDR(ADDR_TB)
            ) U6 (
                .WrData(WrData_TB),
                .Address(Address_TB),
                .WrEn(WrEn_TB),
                .RdEn(RdEn_TB),
                .CLK(CLK_TB),
                .RST(RST_TB),
                .RdData(RdData_TB)
            );
endmodule