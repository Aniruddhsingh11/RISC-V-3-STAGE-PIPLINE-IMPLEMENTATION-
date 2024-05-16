module Program_Counter(clk,PC_in,PC_out);
//declaring input / output ports
input clk, reset;
input [31:0] PC_in; // 32 bits input 
output reg [31:0] PC_out ; // 32 bits output

always @ (posedge clk) // as PC is a register that holds the address for the next 
begin
    if (reset)
    PC_out <=32'h0000000;
    else 
    PC_out <= PC_in;
end 
endmodule