`include " Alu_decoder.v"
`include "main_decoder.v"

module Control_unit_top(Op , RegWrite ,ImmSrc , ALUSrc , MemoWrite , ResultSrc , branch , funct3 , funct7 , ALUControl);

input [31:0] Op , funct7;
input [2:0] funct3;
output RegWrite, ALUSrc , MemoWrite , ResultSrc , branch ;

output [1:0] ImmSrc;
output [2:0] ALUControl;

wire [1:0] ALUOp ;

main_decoder main_decoder(
    .op(op) ,
    .zero(zero) , 
    .RegWrite(RegWrite), 
    .MemoWrite(MemoWrite) , 
    .ResultSrc(ResultSrc) , 
    .ALUSrc(ALUSrc) , 
    .ImmSrc(ImmSrc),
    .ALUOp(ALUOp) , 
    .PCSrc(PCSrc)
);

Alu_decoder Alu_decoder(
    .ALUOp(ALUOp) , 
    .op5(op5) , 
    .funct3(funct3) , 
    .funct7(funct3) , 
    .ALUControl(ALUControl)
);

endmodule