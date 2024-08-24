module ALU (
    input wire [15:0] A,            // 16-bit input operand A
    input wire [15:0] B,            // 16-bit input operand B
    input wire [3:0]  ALU_FUN,      // 4-bit input signal that determines the ALU operation
    input wire        clk,          // Clock input for synchronous operation
    input wire        rst,          // Reset input for for reset ALU module
    output reg [15:0] ALU_OUT,      // 16-bit output result of ALU operations
    output reg       Arith_Flag,    // Flag for arithmetic operations
    output reg       Logic_Flag,    // Flag for logic operations
    output reg       CMP_Flag,      // Flag for comparison operations
    output reg       Shift_Flag     // Flag for shift operations
);
  
  //Declare internal signals
  reg [15:0] re              ; // Register to hold intermediate results
  reg        Arith_Flag_comb ;
  reg        Logic_Flag_comb ;
  reg        CMP_Flag_comb   ;
  reg        Shift_Flag_comb ;

    /////////////////////////////////////////////////////////////////////////////////
   ///// Sequential logic to reset or update ALU_OUT with the computed result /////
  /////////////////////////////////////////////////////////////////////////////////
  always @(posedge clk or negedge rst) begin
    if (!rst) begin
      ALU_OUT    <= 1'b0;
      Arith_Flag <= 1'b0;
      Logic_Flag <= 1'b0; 
      CMP_Flag   <= 1'b0;
      Shift_Flag <= 1'b0;  
    end
    else begin
      ALU_OUT <= re;
      Arith_Flag <= Arith_Flag_comb;
      Logic_Flag <= Logic_Flag_comb; 
      CMP_Flag   <= CMP_Flag_comb  ;
      Shift_Flag <= Shift_Flag_comb; 
    end
  end

    ///////////////////////////////////////////////////////////////////////////////////////
   ///// Combinational logic to perform ALU operations and set the appropriate flags /////
  ///////////////////////////////////////////////////////////////////////////////////////
  always @(*) begin
      // Reset all flags initially and result register to zero
      Arith_Flag_comb = 1'b0;
      Logic_Flag_comb = 1'b0; 
      CMP_Flag_comb   = 1'b0;
      Shift_Flag_comb = 1'b0;

      re = 16'b0;

      // Perform ALU operations and set the flags based on the operation
      case (ALU_FUN)
          4'b0000 : begin
              re = A + B;        // Addition
              Arith_Flag_comb = 1'b1; // Set arithmetic flag
          end
          4'b0001 : begin
              re = A - B;        // Subtraction
              Arith_Flag_comb = 1'b1; // Set arithmetic flag
          end
          4'b0010 : begin
              re = A * B;        // Multiplication
              Arith_Flag_comb = 1'b1; // Set arithmetic flag
          end
          4'b0011 : begin
              re = A / B;        // Division
              Arith_Flag_comb = 1'b1; // Set arithmetic flag
          end
          4'b0100 : begin
              re = A & B;        // Bitwise AND
              Logic_Flag_comb = 1'b1; // Set logic flag
          end
          4'b0101 : begin
              re = A | B;        // Bitwise OR
              Logic_Flag_comb = 1'b1; // Set logic flag
          end
          4'b0110 : begin
              re = ~(A & B);     // Bitwise NAND
              Logic_Flag_comb = 1'b1; // Set logic flag
          end
          4'b0111 : begin
              re = ~(A | B);     // Bitwise NOR
              Logic_Flag_comb = 1'b1; // Set logic flag
          end
          4'b1000 : begin
              re = A ^ B;        // Bitwise XOR
              Logic_Flag_comb = 1'b1; // Set logic flag
          end
          4'b1001 : begin
              re = (A ^~ B);     // Bitwise XNOR
              Logic_Flag_comb = 1'b1; // Set logic flag
          end
          4'b1010 : begin
              re = (A == B) ? 16'b1 : 16'b0; // Equality comparison
              CMP_Flag_comb = 1'b1; // Set comparison flag
          end
          4'b1011 : begin
              re = (A > B) ? 16'b10 : 16'b0; // Greater than comparison
              CMP_Flag_comb = 1'b1; // Set comparison flag
          end
          4'b1100 : begin
              re = (A < B) ? 16'b11 : 16'b0; // Less than comparison
              CMP_Flag_comb = 1'b1; // Set comparison flag
          end
          4'b1101 : begin
              re = A >> 1;      // Logical right shift
              Shift_Flag_comb = 1'b1; // Set shift flag
          end
          4'b1110 : begin
              re = A << 1;      // Logical left shift
              Shift_Flag_comb = 1'b1; // Set shift flag
          end
          default : begin
              re = 16'b0; // Default case: result is zero 
          end
      endcase
  end
  
endmodule
