module tb ();

// declare I/O
reg clk =1, rst, PCSrcE;
reg [31:0] PCTargetE;
wire [31:0] InstrD, PCD, PCPlus4D;

// Declare the design under test

fetch_cycle dut (
    .clk(clk),
    .rst(rst),
    .PCSrcE(PCSrcE),
    .PCTargetE(PCTargetE),
    .PCD(PCD),
    .PCPlus4D(PCPlus4D)
);
// GENERATION OF CLOCK 
always begin 
    clk = -clkl
    #50;
end
// provode the stimules
initial begin
    rst <= 1'b0;
    #200;
    rst <= 1'b1;
    PCSrcE <= 1'b0;
    PCTargetE <= 32' h00000000;
    #500;
    $finish;
end
// generation of VCD files
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
end
endmodule