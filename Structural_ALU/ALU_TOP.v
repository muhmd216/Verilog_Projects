module ALU_TOP #(
    parameter OP_DATA_WIDTH = 16,
              Arith_OUT_WIDTH = OP_DATA_WIDTH + OP_DATA_WIDTH,
              Logic_OUT_WIDTH = OP_DATA_WIDTH,
              Shift_OUT_WIDTH = OP_DATA_WIDTH,
              CMP_OUT_WIDTH   = 2 
) (
    input wire signed [OP_DATA_WIDTH-1:0]      A,
    input wire signed [OP_DATA_WIDTH-1:0]      B,
    input wire [3:0]                           ALU_FUN,
    input wire                                 CLK,
    input wire                                 RST,
    output wire signed [Arith_OUT_WIDTH-1:0]   Arith_OUT,
    output wire                                Carry_OUT,
    output wire                                Arith_Flag,
    output wire [Logic_OUT_WIDTH-1:0]          Logic_OUT,
    output wire                                Logic_Flag,
    output wire [CMP_OUT_WIDTH-1:0]            CMP_OUT,
    output wire                                CMP_Flag,
    output wire [Shift_OUT_WIDTH-1:0]          Shift_OUT,
    output wire                                Shift_Flag
);

  //Internal Signals Declaration
  wire      Arith_Enable ;
  wire      Logic_Enable ;
  wire      CMP_Enable ;
  wire      Shift_Enable ;

// Decoder instance 
Decoder U0 (
    .alu_fun(ALU_FUN[3:2]),
    .rst(RST),
    .arith_enable(Arith_Enable),
    .logic_enable(Logic_Enable),
    .cmp_enable(CMP_Enable),
    .shift_enable(Shift_Enable)
);

// ARITHMETIC_UNIT Instance
ARITHMETIC_UNIT #(.in_data_width(OP_DATA_WIDTH),
                  .out_data_width(Arith_OUT_WIDTH)) U1 (
   .a(A),
   .b(B),
   .alu_fun(ALU_FUN[1:0]),
   .clk(CLK),
   .rst(RST),
   .arith_enable(Arith_Enable),
   .arith_out(Arith_OUT),
   .carry_out(Carry_OUT),
   .arith_flag(Arith_Flag)
                  );

//Logic_UNIT Instance
Logic_UNIT #(.in_data_width(OP_DATA_WIDTH),
             .out_data_width(Logic_OUT_WIDTH)) U2 (
   .a(A),
   .b(B),
   .alu_fun(ALU_FUN[1:0]),
   .clk(CLK),
   .rst(RST),
   .logic_enable(Logic_Enable),
   .logic_out(Logic_OUT),
   .logic_flag(Logic_Flag)
             );

//CMP_UNIT Instance
CMP_UNIT #(.in_data_width(OP_DATA_WIDTH),
           .out_data_width(CMP_OUT_WIDTH)) U3 (
   .a(A),
   .b(B),
   .alu_fun(ALU_FUN[1:0]),
   .clk(CLK),
   .rst(RST),
   .cmp_enable(CMP_Enable),
   .cmp_out(CMP_OUT),
   .cmp_flag(CMP_Flag)
);

//Shift_UNIT Instance
Shift_UNIT #(.in_data_width(OP_DATA_WIDTH),
             .out_data_width(Shift_OUT_WIDTH)) U4 (
   .a(A),
   .b(B),
   .alu_fun(ALU_FUN[1:0]),
   .clk(CLK),
   .rst(RST),
   .shift_enable(Shift_Enable),
   .shift_out(Shift_OUT),
   .shift_flag(Shift_Flag)
);

endmodule