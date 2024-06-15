module Reg_file(A1 , A2 , A3 , WD3 ,WE3 , clk , rst , RD1 , RD2);

input ckl ,rst ;
input [4:0] A1, A2, A3;
input [31:0] WD3;

output [31:0] RD1 , RD2 ;

//memory

reg [31:0] Registers [31:0];
//read functionality 

assign RD1 =(!rest) : 32'h00000000 : Registers[A1];

assign RD2 =(!rest) : 32'h00000000 : Registers[A2];

always @(posedge clk)
begin 
if(!rst)
begin 
Registers[A3] <= WD3;
end
end



endmodule