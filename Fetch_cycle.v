`include "PC.v"
`include "PC_Adder.v"
`include "Mux.v"
`include "Instruction_Memory.v"



module fetch_cycle(clk,rst,PCTargetE,InstrD,PCD,PCPlus4D);
//declare inputs and outputs
input clk, rst;
input PCSrcE;
input [31:0] PCTargetE;
output [31:0] InstrD;
output [31:0]  PCD , PCPlus4D;

//declaring interim wires
wire [31:0] PC_F, PCF, PCPlus4F;
wire [31:0] InstrF;
// declaration of register
reg [31:0] InstrF_reg;
reg [31:0] PCF_reg,PCPlus4F_reg;
// Initiation of modules
// Declare PC Mux
Mux PC_MUX (.a(PCPlus4F),
            .b(PCTargetE),
            .s(PCSrcE),
            .c(PC_F));
// Declare PC counter 
PC_Module Program_Counter(
    .clk(clk),
    .rst(rst),
    .PC(PC_F),
    .PC_NEXT(PCF)
);
// Declare Instruction Memory
Instruction_Memory IMEM (.rst(rst),
.A(PCF),
.RD(InstrF)
);
// declare PC adder
PC_Adder PC_adder(
    .a(PCF),
    .b(32'h00000004),
    .c(PCPlus4F)
);
// fetch cycle register logic
always @(posedge clk or negedge rst) begin
    if(rst == 1'b0) begin
        InstrF_reg <= 32'h00000000;
        PCF_reg <= 32'h00000000;
        PCPlus4F_reg <= 32'h00000000;
        
end
else  begin
    InstrF_reg <= InstrF;
    PCF_reg <= PCF;
    PCPlus4F_reg <= PCPlus4F;
end
end
// assigning Registers Values to the output port
assign InstrD = (rst == 1'b0) ? 32'h00000000 : InstrF_reg;
assign PCD = (rst == 1'b0) ? 32'h00000000 : PCF_reg;
assign PCPlus4D = (rst == 1'b0) ? 32'h00000000 : PCPlus4F_reg;





endmodule